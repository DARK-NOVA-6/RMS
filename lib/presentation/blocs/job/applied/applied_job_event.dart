part of 'applied_job_bloc.dart';

abstract class AppliedJobEvent extends Equatable {
  const AppliedJobEvent();
}

class FetchMoreEvent extends AppliedJobEvent {
  final int limit;
  final List<AppliedJob> oldData;

  const FetchMoreEvent({required this.limit, required this.oldData});

  @override
  List<Object?> get props => [limit, oldData];
}

class GetDetailedEvent extends AppliedJobEvent {
  final String id;

  const GetDetailedEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
