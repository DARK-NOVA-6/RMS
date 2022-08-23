import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/job/recommended_job.dart';

part 'recommended_job_event.dart';

part 'recommended_job_state.dart';

class RecommendedJobBloc
    extends Bloc<RecommendedJobEvent, RecommendedJobState> {
  RecommendedJobBloc() : super(InitialState()) {
    on<GetDetailedEvent>(_getDetailedEventHandel);
    on<FetchMoreEvent>(_fetchMoreEventHandel);
  }

  void _getDetailedEventHandel(GetDetailedEvent event, Emitter emitter) {}

  void _fetchMoreEventHandel(FetchMoreEvent event, Emitter emitter) {}
}
