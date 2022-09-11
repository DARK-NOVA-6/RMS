import 'package:untitled/domain/repositories/job/unavailable_repo.dart';

import '../../../../injection_container.dart';

class AddInquiryUnavailable {
  final UnavailableRepo unavailableRepo;

  AddInquiryUnavailable() : unavailableRepo = sl();

  Future<void> call({required String inquiry, required String jobId}) =>
      unavailableRepo.addInquiry(inquiry: inquiry, jobId: jobId);
}
