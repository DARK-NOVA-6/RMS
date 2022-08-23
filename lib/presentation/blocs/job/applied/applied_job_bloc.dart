import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/domain/entities/job/applied_job.dart';

part 'applied_job_event.dart';

part 'applied_job_state.dart';

class AppliedJobBloc extends Bloc<AppliedJobEvent, AppliedJobState> {
  AppliedJobBloc() : super(InitialState()) {
    on<GetDetailedEvent>(_getDetailedEventHandel);
    on<FetchMoreEvent>(_fetchMoreEventHandel);
  }

  void _getDetailedEventHandel(GetDetailedEvent event, Emitter emitter) {}

  void _fetchMoreEventHandel(FetchMoreEvent event, Emitter emitter) {}
}
