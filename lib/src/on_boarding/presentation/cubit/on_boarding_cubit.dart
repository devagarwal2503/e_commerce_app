import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/src/on_boarding/domain/usecases/cache_first_timer_usecase.dart';
import 'package:e_commerce_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer_usecase.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit({
    required CacheFirstTimerUsecase cacheFirstTimerUsecase,
    required CheckIfUserIsFirstTimerUsecase checkingIfUserIsFirstTimerUsecase,
  }) : _cacheFirstTimerUsecase = cacheFirstTimerUsecase,
       _checkingIfUserIsFirstTimerUsecase = checkingIfUserIsFirstTimerUsecase,
       super(const OnBoardingInitial());

  final CacheFirstTimerUsecase _cacheFirstTimerUsecase;
  final CheckIfUserIsFirstTimerUsecase _checkingIfUserIsFirstTimerUsecase;

  Future<void> cacheFirstTimer() async {
    emit(CachingFirstTimer());

    final result = await _cacheFirstTimerUsecase();

    result.fold(
      (failure) => emit(OnBoardingError(failure.errorMessage)),
      (_) => emit(UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(CheckingIfUserIsFirstTimer());
    final result = await _checkingIfUserIsFirstTimerUsecase();

    result.fold(
      (failure) => emit(OnBoardingStatus(isFirstTimer: true)),
      (status) => emit(OnBoardingStatus(isFirstTimer: status)),
    );
  }
}
