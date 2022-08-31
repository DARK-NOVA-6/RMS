import 'package:equatable/equatable.dart';

import 'evaluated_job.dart';

class FullEvaluatedJob extends Equatable {
  final EvaluatedJob evaluatedJob;

  const FullEvaluatedJob({
    required this.evaluatedJob,
  });

  @override
  List<Object?> get props => [evaluatedJob];
}
