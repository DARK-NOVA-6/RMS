part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class GetSignInEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class GetSignUpEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String confPassword;

  @override
  List<Object?> get props => [
        email,
        password,
        confPassword,
      ];

  const SignUpEvent({
    required this.email,
    required this.password,
    required this.confPassword,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  @override
  List<Object?> get props => [
        email,
        password,
      ];

  const LoginEvent({
    required this.email,
    required this.password,
  });
}
