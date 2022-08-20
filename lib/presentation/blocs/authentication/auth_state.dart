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
  List<Object> get props => [user];

  const SignedUpState({
    required this.user,
  });
}

class SigningInState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedInState extends AuthState {
  final User user;

  @override
  List<Object> get props => [];

  const SignedInState({
    required this.user,
  });
}

class SignInErrorState extends AuthState {
  final String message;

  @override
  List<Object> get props => [];

  const SignInErrorState({
    required this.message,
  });
}

class SignUpErrorState extends AuthState {
  final String message;

  @override
  List<Object> get props => [];

  const SignUpErrorState({
    required this.message,
  });
}

class ConfCodeErrorState extends AuthState {
  final String message;

  @override
  List<Object> get props => [];

  const ConfCodeErrorState({
    required this.message,
  });
}
