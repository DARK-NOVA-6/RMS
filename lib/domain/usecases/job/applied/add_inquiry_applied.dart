import '../../../../injection_container.dart';
import '../../../repositories/job/applied_repo.dart';

class AddInquiryApplied {
  final AppliedRepo appliedRepo;

  AddInquiryApplied() : appliedRepo = sl();

  Future<void> call({required String inquiry, required String jobId}) =>
      appliedRepo.addInquiry(inquiry: inquiry, jobId: jobId);
}
