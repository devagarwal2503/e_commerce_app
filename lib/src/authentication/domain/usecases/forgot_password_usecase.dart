import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/authentication/domain/repository/authentication_repository.dart';

class ForgotPasswordUsecase extends UsecaseWithParameters<void, String> {
  const ForgotPasswordUsecase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<void> call(String parameters) {
    return _authenticationRepository.forgotPassword(email: parameters);
  }
}
