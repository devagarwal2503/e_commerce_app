import 'package:e_commerce_app/core/enums/update_user.dart';
import 'package:e_commerce_app/src/authentication/data/models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({
    required updateUserAction action,
    required dynamic userData,
  });
}
