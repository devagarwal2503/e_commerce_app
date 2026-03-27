import 'package:e_commerce_app/core/enums/update_user.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/authentication/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultFuture<void> forgotPassword({required String email});

  ResultFuture<void> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> updateUser({
    required updateUserAction action,
    required dynamic userData,
  });
}
