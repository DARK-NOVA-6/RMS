part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();
}


class GetRecommendedEvent extends JobEvent {
  final String userId;

  const GetRecommendedEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetUnavailableEvent extends JobEvent {
  final String userId;

  const GetUnavailableEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetAppliedEvent extends JobEvent {
  final String userId;

  const GetAppliedEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetDetailedEvent extends JobEvent {
  final String userId;
  final String jobId;

  const GetDetailedEvent({required this.userId, required this.jobId});

  @override
  List<Object?> get props => [userId, jobId];
}
