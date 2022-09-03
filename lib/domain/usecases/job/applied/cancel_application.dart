import '../../../repositories/job/applied_repo.dart';

class CancelApplication {
  final AppliedRepo appliedRepo;

  CancelApplication(this.appliedRepo);

  Future<String> call({required String appliedId}) async {
    String result = '';
    (await appliedRepo.cancel(id: appliedId)).fold(
      (failure) => result = failure.message,
      (data) => result = '',
    );
    return result;
  }
}
