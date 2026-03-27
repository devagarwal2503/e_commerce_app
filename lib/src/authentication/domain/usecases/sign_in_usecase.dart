import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/authentication/domain/entities/user_entity.dart';
import 'package:e_commerce_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class SignInUsecase extends UsecaseWithParameters<void, SignInParameter> {
  const SignInUsecase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<LocalUser> call(SignInParameter parameters) {
    return _authenticationRepository.signIn(
      email: parameters.email,
      password: parameters.password,
    );
  }
}

class SignInParameter extends Equatable {
  const SignInParameter({required this.email, required this.password});

  const SignInParameter.empty() : email = "", password = "";

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
