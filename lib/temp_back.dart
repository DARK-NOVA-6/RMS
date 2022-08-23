import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/domain/entities/entities.dart';

import 'data/models/job_model.dart';

class Temp {
  void getJob({required String id}) async {
    print('test mod..');
    final fireStore = FirebaseFirestore.instance.collection('jobs');
    Job job = Job(
      id: 'some id',
      companyName: 'companyName TEST',
      jobDescription: JobDescription(
        title: 'title TEST',
        languages: [
          'languages1 TEST',
          'languages2 TEST',
        ].toList(),
        experience: [
          'experience1 TEST',
          'experience2 TEST',
          'experience3 TEST',
          'experience4 TEST',
        ].toList(),
        eduQualification: [
          'eduQualification1 TEST',
          'eduQualification2 TEST',
          'eduQualification3 TEST',
          'eduQualification4 TEST',
        ].toList(),
        skills: [
          'skills1 TEST',
          'skills2 TEST',
        ].toList(),
        summary: 'summary summary summary summary TEST',
      ),
      publishedTime: Timestamp.now(),
    );
    final temp = await fireStore.add(JobModel.toSnapshot(job));
    print(temp.id);
  }
}
