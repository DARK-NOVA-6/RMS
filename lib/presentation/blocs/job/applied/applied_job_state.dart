part of 'applied_job_bloc.dart';

abstract class AppliedJobState extends Equatable {
  const AppliedJobState();
}

class InitialState extends AppliedJobState {
  final List<AppliedJob> oldData = [];

  @override
  List<Object> get props => [oldData];
}

class LoadingState extends AppliedJobState {
  final List<AppliedJob> oldData;

  const LoadingState({required this.oldData});

  @override
  List<Object?> get props => [oldData];
}

class LoadedState extends AppliedJobState {
  final List<AppliedJob> data;

  const LoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorState extends AppliedJobState {
  final List<AppliedJob> oldData;
  final String message;

  const ErrorState({required this.oldData, required this.message});

  @override
  List<Object?> get props => [oldData];
}
