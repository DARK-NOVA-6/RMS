part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class SigningUpState extends AuthState {
  @override
  List<Object> get props => [];
}

class PendingConfCodeState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedUpState extends AuthState {
  final User user;

  @override
  List<Object> get props => [];
}

class SigningInState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedInState extends AuthState {
  final User user;

  @override
  List<Object> get props => [];
}

class SignInErrorState extends AuthState {
  final String message;

  @override
  List<Object> get props => [];
}

class SignUpErrorState extends AuthState {
  final String message;

  @override
  List<Object> get props => [];
}

class ConfCodeErrorState extends AuthState {
  final String message;

  @override
  List<Object> get props => [];
}
