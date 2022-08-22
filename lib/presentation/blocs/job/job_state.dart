part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();
}

class JobInitial extends JobState {
  @override
  List<Object> get props => [];
}
