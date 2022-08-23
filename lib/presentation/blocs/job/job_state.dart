part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();
}

class JobInitial extends JobState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Loading extends JobState {
  @override
  List<Object?> get props => [];
}

class LoadedRecommended extends JobState {
  final List<RecommendedJob> recommendedJobs;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  const LoadedRecommended(this.recommendedJobs);
}
