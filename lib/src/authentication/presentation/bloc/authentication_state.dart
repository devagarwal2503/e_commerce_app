part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationBlocInitial extends AuthenticationState {
  const AuthenticationBlocInitial();
}

class AuthenticationLoadingState extends AuthenticationState {
  const AuthenticationLoadingState();
}

class SignInSuccessState extends AuthenticationState {
  const SignInSuccessState({required this.user});

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

class SignUpSuccessState extends AuthenticationState {
  const SignUpSuccessState();
}

class ForgotPasswordSentState extends AuthenticationState {
  const ForgotPasswordSentState();
}

class UserUpdatedSuccessState extends AuthenticationState {
  const UserUpdatedSuccessState();
}

class AuthenticationErrorState extends AuthenticationState {
  const AuthenticationErrorState({required this.errorMessage});

  final String errorMessage;

  @override
  List<String> get props => [errorMessage];
}
