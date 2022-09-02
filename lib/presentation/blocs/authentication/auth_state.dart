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
  @override
  List<Object> get props => [];

  const SignedUpState();
}

class SigningInState extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedInState extends AuthState {
  @override
  List<Object> get props => [];

  const SignedInState();
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

class Loading extends AuthState {
  @override
  List<Object> get props => [];
}
