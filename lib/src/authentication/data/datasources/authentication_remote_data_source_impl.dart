import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/enums/update_user.dart';
import 'package:e_commerce_app/core/errors/exception.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:e_commerce_app/src/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImpl({
    required FirebaseAuth authCLient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  }) : _authCLient = authCLient,
       _cloudStoreClient = cloudStoreClient,
       _dbClient = dbClient;
  final FirebaseAuth _authCLient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;

  //AuthenticationRemoteDataSourceImpl
  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _authCLient.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw APIException(
        message: e.message ?? "Error Occurred",
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw APIException(message: e.toString(), statusCode: "505");
    }
  }

  @override
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authCLient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        APIException(
          message: "Please try again later",
          statusCode: "Unknown Error",
        );
      }
      var userData = await _getUserData(user!.uid);

      if (userData.exists) {
        return LocalUserModel.fromMap(userData.data()!);
      }

      await _setUserData(user, email);

      userData = await _getUserData(user.uid);

      return LocalUserModel.fromMap(userData.data()!);
    } on FirebaseAuthException catch (e) {
      throw APIException(
        message: e.message ?? "Error Occurred",
        statusCode: e.code,
      );
    } on APIException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw APIException(message: e.toString(), statusCode: "505");
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final userCredential = await _authCLient.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(fullName);

      await userCredential.user?.updatePhotoURL(kDefaultAvatar);

      await _setUserData(_authCLient.currentUser!, email);
    } on FirebaseAuthException catch (e) {
      throw APIException(
        message: e.message ?? "Error Occurred",
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw APIException(message: e.toString(), statusCode: "505");
    }
  }

  @override
  Future<void> updateUser({
    required updateUserAction action,
    required dynamic userData,
  }) async {
    try {
      switch (action) {
        case updateUserAction.email:
          await _authCLient.currentUser?.verifyBeforeUpdateEmail(
            userData as String,
          );
          await _updateUserData({'email': userData});
          break;
        case updateUserAction.displayName:
          await _authCLient.currentUser?.updateDisplayName(userData);
          await _updateUserData({'fullName': userData});
          break;
        case updateUserAction.profilePic:
          final ref = _dbClient.ref().child(
            'profile_pics/${_authCLient.currentUser?.uid}',
          );

          await ref.putFile(userData as File);
          final url = await ref.getDownloadURL();
          await _authCLient.currentUser?.updatePhotoURL(url);
          await _updateUserData({'profilePic': url});
          break;
        case updateUserAction.password:
          if (_authCLient.currentUser?.email == null) {
            throw APIException(
              message: "User does not exist",
              statusCode: "Insufficient Permissions",
            );
          }
          final newData = jsonDecode(userData as String) as DataMap;

          await _authCLient.currentUser?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _authCLient.currentUser!.email!,
              password: newData['oldPassword'],
            ),
          );

          await _authCLient.currentUser?.updatePassword(
            newData['newPassword'] as String,
          );
          break;
      }
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? "Error Occurred",
        statusCode: e.code,
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw APIException(message: e.toString(), statusCode: "505");
    }
  }

  Future<DocumentSnapshot<DataMap>> _getUserData(String uid) async {
    return _cloudStoreClient.collection('users').doc(uid).get();
  }

  Future<void> _setUserData(User user, String fallBackEmail) async {
    await _cloudStoreClient
        .collection('users')
        .doc(user.uid)
        .set(
          LocalUserModel(
            uid: user.uid,
            email: user.email ?? fallBackEmail,
            fullName: user.displayName ?? "",
            profilePic: user.photoURL ?? "",
          ).toMap(),
        );
  }

  Future<void> _updateUserData(DataMap data) async {
    await _cloudStoreClient
        .collection('users')
        .doc(_authCLient.currentUser?.uid)
        .update(data);
  }
}
