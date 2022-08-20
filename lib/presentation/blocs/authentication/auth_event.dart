part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class GetSignInEvent extends AuthEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetSignUpEvent extends AuthEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetConfCodeEvent extends AuthEvent {
  final String email;
  final String password;
  final String confPassword;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SubmitConfCodeEvent extends AuthEvent {
  final String code;

  @override
  List<Object?> get props => throw UnimplementedError();
}
