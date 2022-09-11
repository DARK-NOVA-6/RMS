import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/utils/custom_converter.dart';
import '../../../domain/entities/job/inquiry_job.dart';
import '../../../domain/repositories/authentication_repo.dart';
import '../../models/job/inquiry_job_model.dart';

class AddInquiryMethod {
  final CollectionReference<Map<String, dynamic>> collection;
  final CollectionReference<Map<String, dynamic>> collection2;
  final AuthenticationRepo authenticationRepo;
  final FirebaseFirestore firebaseFirestore;

  AddInquiryMethod({
    required this.authenticationRepo,
    required this.firebaseFirestore,
  })  : collection = firebaseFirestore.collection('jobs'),
        collection2 = firebaseFirestore.collection('jobs-applications');

  Future<void> call({required String inquiry, required String jobId}) async {
    List<InquiryJob> inquiries = InquiryJobModel.fromJsonAndSnapshot(
      CustomConverter.convertToListMap(
        (await collection.doc(jobId).get()).data()!['inquiries'],
      ),
    );
    String name = '';
    if (authenticationRepo.connectedUser!.firstName != null) {
      name = authenticationRepo.connectedUser!.firstName!;
    }
    if (authenticationRepo.connectedUser!.middleName != null) {
      name += authenticationRepo.connectedUser!.middleName!;
    }
    if (authenticationRepo.connectedUser!.lastName != null) {
      name += authenticationRepo.connectedUser!.lastName!;
    }

    if (name.isEmpty) {
      name = 'No Name';
    }
    InquiryJob inquiryJob = InquiryJob(
      inquiry: inquiry,
      name: name,
      inquiryDate: Timestamp.now(),
    );
    inquiries.add(inquiryJob);
    await collection.doc(jobId).update({
      'inquiries': InquiryJobModel.toJsonAndSnapshot(inquiries),
    });
    var all = await collection2.where('job-id', isEqualTo: jobId).get();
    for (var application in all.docs) {
      List<InquiryJob> inquiries = InquiryJobModel.fromJsonAndSnapshot(
        CustomConverter.convertToListMap(
          application.data()['inquiries'],
        ),
      );
      inquiries.add(inquiryJob);
      collection2.doc(application.id).update({
        'inquiries': InquiryJobModel.toJsonAndSnapshot(inquiries),
      });
    }
  }
}
