
import '../../../domain/entities/job/job_application_states.dart';

class ApplicationStatesModel {
  static String stateToString(ApplicationStates? state) {
    if (state == ApplicationStates.hired) return 'hired';
    if (state == ApplicationStates.interviewing) return 'interviewing';
    if (state == ApplicationStates.reviewing) return 'reviewing';
    if (state == ApplicationStates.screening) return 'screening';
    if (state == ApplicationStates.rejected) return 'rejected';
    return '';
  }

  static ApplicationStates? stringToState(String state) {
    if (state == 'hired') return ApplicationStates.hired;
    if (state == 'interviewing') return ApplicationStates.interviewing;
    if (state == 'reviewing') return ApplicationStates.reviewing;
    if (state == 'screening') return ApplicationStates.screening;
    if (state == 'rejected') return ApplicationStates.rejected;
    return null;
  }
}
