import 'package:e_commerce_app/core/usecase/usecase.dart';
import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/on_boarding/domain/repository/on_boarding_repository.dart';

class CacheFirstTimerUsecase extends UsecaseWithoutParameters<void> {
  const CacheFirstTimerUsecase(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<void> call() async {
    return _repository.cacheFirstTimer();
  }
}
