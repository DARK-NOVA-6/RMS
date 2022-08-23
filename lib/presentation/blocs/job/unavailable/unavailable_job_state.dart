part of 'unavailable_job_bloc.dart';

abstract class UnavailableJobState extends Equatable {
  const UnavailableJobState();
}

class InitialState extends UnavailableJobState {
  final List<UnavailableJob> oldData = [];

  @override
  List<Object> get props => [oldData];
}

class LoadingState extends UnavailableJobState {
  final List<UnavailableJob> oldData;

  const LoadingState({required this.oldData});

  @override
  List<Object?> get props => [oldData];
}

class LoadedState extends UnavailableJobState {
  final List<UnavailableJob> data;

  const LoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorState extends UnavailableJobState {
  final List<UnavailableJob> oldData;
  final String message;

  const ErrorState({required this.oldData, required this.message});

  @override
  List<Object?> get props => [oldData];
}
