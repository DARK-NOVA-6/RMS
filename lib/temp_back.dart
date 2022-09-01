import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/domain/usecases/job/unavailable/fetch_more.dart';
import 'domain/usecases/job/recommended/fetch_more.dart';
import 'domain/usecases/user/get_profile_user.dart';
import 'domain/entities/user/user_info.dart' as user_info;
import 'domain/usecases/user/update_profile_user.dart';
import 'injection_container.dart';

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

  void updateUser() {
    user_info.UserInfo userInfo = const user_info.UserInfo(
      email: 'don\'t use this email',
      rating: 2.0,
      firstName: 'first name',
      middleName: 'middle name',
      lastName: 'last name',
      imgUrl: '',
      gender: 'Male',
      nationality: 'Syrian',
      location: 'Syria',
      summary: 'useless summary, this is an empty user',
      skills: ['c++', 'php'],
      languages: [],
      phones: [],
      emails: [],
      experiences: [],
      eduQualifications: [],
    );
    UpdateProfileUser updateProfileUser = UpdateProfileUser(userInfoRepo: sl());
    updateProfileUser(newUserInfo: userInfo);
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
    Temp().updateUser();

    FetchMoreRecommended fetchMoreRecommended = FetchMoreRecommended(sl());
    FetchMoreUnavailable fetchMoreUnavailable = FetchMoreUnavailable(sl());
    GetProfileUser getProfileUser = GetProfileUser(userInfoRepo: sl());
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
            child: const Text('refresh recommended'),
            onPressed: () => fetchMoreRecommended.refresh(),
          ),
          TextButton(
            child: const Text('fetch more unavailable'),
            onPressed: () async {
              print(await fetchMoreUnavailable(limit: 1));
            },
          ),
          TextButton(
            child: const Text('refresh unavailable'),
            onPressed: () => fetchMoreUnavailable.refresh(),
          ),
          TextButton(
            child: const Text('get profile info'),
            onPressed: () async {
              print(
                  await getProfileUser(userId: 'KWKKUrBFSAPT7sqtP24nqa2gduN2'));
            },
          ),
        ],
      ),
    );
  }
}
