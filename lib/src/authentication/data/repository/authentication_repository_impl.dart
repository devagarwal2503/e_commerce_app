import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/enums/update_user.dart';
import 'package:e_commerce_app/core/errors/exception.dart';
import 'package:e_commerce_app/core/errors/failures.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:e_commerce_app/src/authentication/domain/entities/user_entity.dart';
import 'package:e_commerce_app/src/authentication/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._authenticationRemoteDataSource);
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  @override
  ResultFuture<void> forgotPassword({required String email}) async {
    try {
      await _authenticationRemoteDataSource.forgotPassword(email);
      return right(null);
    } on APIException catch (e) {
      throw left(APIFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authenticationRemoteDataSource.signIn(
        email: email,
        password: password,
      );
      return right(result);
    } on APIException catch (e) {
      throw left(APIFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationRemoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return right(null);
    } on APIException catch (e) {
      throw left(APIFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateUser({
    required updateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _authenticationRemoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return right(null);
    } on APIException catch (e) {
      throw left(APIFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
