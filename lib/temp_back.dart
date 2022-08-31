import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/data/datasources/remote/evaluator_api.dart';
import 'package:untitled/data/repositories/job/unavailable_repo_imp.dart';
import 'package:untitled/domain/usecases/job/unavailable/fetch_more.dart';
import 'data/repositories/job/recommended_repo_imp.dart';
import 'domain/usecases/job/recommended/fetch_more.dart';

class Temp {
  void getJob({required String id}) async {
    print('test mod..');
    final fireStore = FirebaseFirestore.instance.collection('jobs');
    await fireStore.add({
      'company-name': 'Facebook',
      'summary': 'summary 2',
      'title': 'title 2',
      'published-time': Timestamp.now(),
      'edu-qualifications': [
        {
          'degree': 'Master',
          'field': 'Software Engineer',
          'is-required': false,
        },
        {
          'degree': 'Bachelor',
          'field': 'Software Engineer',
          'is-required': true,
        },
      ],
      'experiences': [],
      'languages': [
        {
          'title': 'English',
          'is-required': true,
        },
        {
          'title': 'Arabic',
          'is-required': false,
        },
      ],
      'skills': [
        {
          'title': 'data migration',
          'is-required': false,
        },
        {
          'title': 'asp',
          'is-required': true,
        },
        {
          'title': 'php',
          'is-required': true,
        }
      ],
    });
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
    final myapi = EvaluatorApiImp();
    // Temp().getJob(id: 'id');
    final temp = RecommendedRepoImp(
      firebaseFirestore: FirebaseFirestore.instance,
      evaluatorApi: EvaluatorApiImp(),
      userId: 'KNvVSQq2xSUaxUNsEbHCu5VvHWv2',
    );
    FetchMoreRecommended fetchMoreRecommended = FetchMoreRecommended(temp);
    FetchMoreUnavailable fetchMoreUnavailable =
        FetchMoreUnavailable(UnavailableRepoImp(
      firebaseFirestore: FirebaseFirestore.instance,
      evaluatorApi: EvaluatorApiImp(),
      userId: 'KNvVSQq2xSUaxUNsEbHCu5VvHWv2',
    ));
    return MaterialApp(
      home: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            child: const Text('fetch more recommended'),
            onPressed: () async {
              print(await fetchMoreRecommended(limit: 1));
            },
          ),
          TextButton(
            child: const Text('fetch more unavailable'),
            onPressed: () async {
              print(await fetchMoreUnavailable(limit: 1));
            },
          ),
        ],
      ),
    );
  }
}
