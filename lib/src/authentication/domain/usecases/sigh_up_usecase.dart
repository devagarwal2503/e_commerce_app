import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class SignUpUsecase extends UsecaseWithParameters<void, SignUpParameter> {
  const SignUpUsecase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<void> call(SignUpParameter parameters) {
    return _authenticationRepository.signUp(
      email: parameters.email,
      password: parameters.password,
      fullName: parameters.fullName,
    );
  }
}

class SignUpParameter extends Equatable {
  const SignUpParameter({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParameter.empty() : email = "", password = "", fullName = "";

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [email, password, fullName];
}
