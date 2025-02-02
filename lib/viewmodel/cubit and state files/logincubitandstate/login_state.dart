part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String userId;

  LoginSuccess(this.userId);
}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}

final class LogoutSuccess extends LoginState {}

final class LogoutFailure extends LoginState {
  final String errorMessage;

  LogoutFailure(this.errorMessage);
}
