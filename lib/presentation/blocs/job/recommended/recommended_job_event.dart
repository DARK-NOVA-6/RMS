part of 'recommended_job_bloc.dart';

abstract class RecommendedJobEvent extends Equatable {
  const RecommendedJobEvent();
}

class FetchMoreEvent extends RecommendedJobEvent {
  final int limit;
  final List<RecommendedJob> oldData;

  const FetchMoreEvent({required this.limit, required this.oldData});

  @override
  List<Object?> get props => [limit, oldData];
}

class GetDetailedEvent extends RecommendedJobEvent {
  final String id;

  const GetDetailedEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
