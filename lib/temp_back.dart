import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/domain/entities/entities.dart';

import 'data/models/job_model.dart';
import 'data/repositories/job/recommended_repo_imp.dart';

class Temp {
  void getJob({required String id}) async {
    print('test mod..');
    final fireStore = FirebaseFirestore.instance.collection('jobs');
    Job job = Job(
      id: 'some id',
      companyName: 'companyName TEST',
      jobDescription: JobDescription(
        title: 'title TEST',
        languages: const [
          DescriptionField(value: 'languages1 TEST', isRequired: false),
          DescriptionField(value: 'languages2 TEST', isRequired: true),
        ].toList(),
        experience: const [
          DescriptionField(value: 'experience1 TEST', isRequired: true),
          DescriptionField(value: 'experience2 TEST', isRequired: false),
          DescriptionField(value: 'experience3 TEST', isRequired: false),
          DescriptionField(value: 'experience4 TEST', isRequired: false),
        ].toList(),
        eduQualification: const [
          DescriptionField(value: 'eduQualification1 TEST', isRequired: false),
          DescriptionField(value: 'eduQualification2 TEST', isRequired: false),
          DescriptionField(value: 'eduQualification3 TEST', isRequired: false),
          DescriptionField(value: 'eduQualification4 TEST', isRequired: false),
        ].toList(),
        skills: const [
          DescriptionField(value: 'skills1 TEST', isRequired: false),
          DescriptionField(value: 'skills2 TEST', isRequired: false),
        ].toList(),
        summary: 'summary summary summary summary TEST',
      ),
      publishedTime: Timestamp.now(),
    );
    final temp = await fireStore.add(JobModel.toSnapshot(job));
    print(temp.id);
  }
}

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    final temp =
        RecommendedRepoImp(firebaseFirestore: FirebaseFirestore.instance);

    return MaterialApp(
      home: TextButton(
        child: const Text('click'),
        onPressed: () async {
          // print(await temp.fetch(limit: 3));
          print(await temp.detailed(id: 'jkfGAHUz0JQkaeINYMeY'));
          // Temp().getJob(id: 'id');
        },
      ),
    );
  }
}
