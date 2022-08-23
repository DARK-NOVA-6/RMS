part of 'unavailable_job_bloc.dart';

abstract class UnavailableJobEvent extends Equatable {
  const UnavailableJobEvent();
}

class FetchMoreEvent extends UnavailableJobEvent {
  final int limit;
  final List<UnavailableJob> oldData;

  const FetchMoreEvent({required this.limit, required this.oldData});

  @override
  List<Object?> get props => [limit, oldData];
}

class GetDetailedEvent extends UnavailableJobEvent {
  final String id;

  const GetDetailedEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
