import '../failures/authentication_failures.dart';
import '../failures/failure.dart';

abstract class AuthenticationException implements Exception {
  AuthenticationException({required this.failure});

  final Failure failure;
}

class EmailAlreadyExistException extends AuthenticationException {
  EmailAlreadyExistException() : super(failure: const EmailAlreadyExist());
}

class WeakPasswordException extends AuthenticationException {
  WeakPasswordException() : super(failure: const WeekPassword());
}

class InvalidEmailException extends AuthenticationException {
  InvalidEmailException() : super(failure: const InvalidEmail());
}

class EmailAndPasswordNotMatchedException extends AuthenticationException {
  EmailAndPasswordNotMatchedException()
      : super(failure: const EmailAndPasswordNotMatched());
}

class UnexpectedAuthException extends AuthenticationException {
  UnexpectedAuthException({Failure failure = const Unexpected()})
      : super(failure: failure);
}
