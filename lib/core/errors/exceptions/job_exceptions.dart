import '../failures/failure.dart';

abstract class JobException implements Exception {
  JobException({required this.failure});

  final Failure failure;
}

class UnexpectedJobException extends JobException {
  UnexpectedJobException({Failure failure = const Unexpected()})
      : super(failure: failure);
}
