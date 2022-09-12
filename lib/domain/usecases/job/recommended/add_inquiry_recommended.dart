import '../../../../injection_container.dart';
import '../../../repositories/job/recommended_repo.dart';

class AddInquiryRecommended {
  final RecommendedRepo recommendedRepo;

  AddInquiryRecommended() : recommendedRepo = sl();

  Future<void> call({required String inquiry, required String jobId}) =>
      recommendedRepo.addInquiry(inquiry: inquiry, jobId: jobId);
}
