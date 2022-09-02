import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/domain/usecases/autocomplete/autocomplete_field_edu.dart';
import 'package:untitled/domain/usecases/autocomplete/autocomplete_job_titles.dart';
import 'package:untitled/domain/usecases/autocomplete/autocomplete_languages.dart';
import 'package:untitled/domain/usecases/autocomplete/autocomplete_skills.dart';
import 'package:untitled/domain/usecases/autocomplete/autocomplete_universities.dart';
import 'package:untitled/domain/usecases/job/unavailable/fetch_more.dart';
import 'domain/usecases/autocomplete/autocomplete_degrees.dart';
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
    UpdateProfileUser updateProfileUser = UpdateProfileUser();
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

    FetchMoreRecommended fetchMoreRecommended = FetchMoreRecommended();
    FetchMoreUnavailable fetchMoreUnavailable = FetchMoreUnavailable();
    GetProfileUser getProfileUser = GetProfileUser();

    String? curr = 'sk';
    String word = 'java';
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
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
                      print(await getProfileUser(
                          userId: 'KWKKUrBFSAPT7sqtP24nqa2gduN2'));
                    },
                  ),
                  Material(
                    child: DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'skill',
                          child: Text('skill'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'language',
                          child: Text('language'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'degree',
                          child: Text('degree'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'job-title',
                          child: Text('job-title'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'university',
                          child: Text('university'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Bachelor',
                          child: Text('Bachelor'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Master',
                          child: Text('Master'),
                        ),
                      ],
                      onChanged: (val) {
                        curr = val.toString();
                      },
                    ),
                  ),
                  TextButton(
                    child: const Text('get complement'),
                    onPressed: () async {
                      if (curr == 'skill') {
                        print(
                          await AutocompleteSkills()(word: word),
                        );
                      }
                      if (curr == 'language') {
                        print(
                          await AutocompleteLanguages()(word: word),
                        );
                      }
                      if (curr == 'degree') {
                        print(
                          await AutocompleteDegrees()(word: word),
                        );
                      }
                      if (curr == 'job-title') {
                        print(
                          await AutocompleteJobTitles()(word: word),
                        );
                      }
                      if (curr == 'university') {
                        print(
                          await AutocompleteUniversities()(word: word),
                        );
                      }

                      if (curr == 'Bachelor') {
                        print(
                          await AutocompleteFieldEdu()(
                              degree: 'Bachelor', word: word),
                        );
                      }
                      if (curr == 'Master') {
                        print(
                          await AutocompleteFieldEdu()(
                              degree: 'Master', word: word),
                        );
                      }
                    },
                  ),
                  Material(
                    child: TextFormField(
                      onChanged: (val) {
                        word = val.toString();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
