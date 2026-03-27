import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/enums/update_user.dart';
import 'package:e_commerce_app/src/authentication/domain/entities/user_entity.dart';
import 'package:e_commerce_app/src/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:e_commerce_app/src/authentication/domain/usecases/sigh_up_usecase.dart';
import 'package:e_commerce_app/src/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:e_commerce_app/src/authentication/domain/usecases/update_user_usecase.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required SignInUsecase signInUsecase,
    required SignUpUsecase signUpUsecase,
    required ForgotPasswordUsecase forgotPasswordUsecase,
    required UpdateUserUsecase updateUserUsecase,
  }) : _signInUsecase = signInUsecase,

       //  _signUpUsecase = signUpUsecase,
       //  _forgotPasswordUsecase = forgotPasswordUsecase,
       //  _updateUserUsecase = updateUserUsecase,
       super(AuthenticationBlocInitial()) {
    on<AuthenticationEvent>((event, emit) {
      emit(AuthenticationLoadingState());
    });

    on<SignInEvent>(_signInHandler);
  }
  final SignInUsecase _signInUsecase;
  // final SignUpUsecase _signUpUsecase;
  // final ForgotPasswordUsecase _forgotPasswordUsecase;
  // final UpdateUserUsecase _updateUserUsecase;

  Future<void> _signInHandler(
    SignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final result = await _signInUsecase(
      SignInParameter(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        return emit(
          AuthenticationErrorState(errorMessage: failure.errorMessage),
        );
      },
      (user) {
        return emit(SignInSuccessState(user: user));
      },
    );
  }
}
