part of 'recommended_job_bloc.dart';

abstract class RecommendedJobState extends Equatable {
  const RecommendedJobState();
}

class InitialState extends RecommendedJobState {
  final List<RecommendedJob> oldData = [];

  @override
  List<Object> get props => [oldData];
}

class LoadingState extends RecommendedJobState {
  final List<RecommendedJob> oldData;

  const LoadingState({required this.oldData});

  @override
  List<Object?> get props => [oldData];
}

class LoadedState extends RecommendedJobState {
  final List<RecommendedJob> data;

  const LoadedState({required this.data});

  @override
  List<Object?> get props => [data];
}

class ErrorState extends RecommendedJobState {
  final List<RecommendedJob> oldData;
  final String message;

  const ErrorState({required this.oldData, required this.message});

  @override
  List<Object?> get props => [oldData];
}
