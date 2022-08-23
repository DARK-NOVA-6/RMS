import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/job/unavailable_job.dart';

part 'unavailable_job_event.dart';

part 'unavailable_job_state.dart';

class UnavailableJobBloc
    extends Bloc<UnavailableJobEvent, UnavailableJobState> {
  UnavailableJobBloc() : super(InitialState()) {
    on<GetDetailedEvent>(_getDetailedEventHandel);
    on<FetchMoreEvent>(_fetchMoreEventHandel);
  }

  void _getDetailedEventHandel(GetDetailedEvent event, Emitter emitter) {}

  void _fetchMoreEventHandel(FetchMoreEvent event, Emitter emitter) {}
}
