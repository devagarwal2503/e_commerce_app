import 'package:e_commerce_app/core/enums/update_user.dart';
import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUsecase
    extends UsecaseWithParameters<void, UpdateUserParameter> {
  const UpdateUserUsecase(this._authenticationRepository);

  final AuthenticationRepository _authenticationRepository;

  @override
  ResultFuture<void> call(UpdateUserParameter parameters) {
    return _authenticationRepository.updateUser(
      action: parameters.action,
      userData: parameters.userData,
    );
  }
}

class UpdateUserParameter extends Equatable {
  const UpdateUserParameter({required this.action, required this.userData});

  const UpdateUserParameter.empty()
    : this(action: updateUserAction.displayName, userData: "");

  final updateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
