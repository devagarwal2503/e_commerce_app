import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

class CheckIfUserIsFirstTimerUsecase extends UsecaseWithoutParameters<bool> {
  const CheckIfUserIsFirstTimerUsecase(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() async {
    return _repository.checkIfUserIsFirstTimer();
  }
}
