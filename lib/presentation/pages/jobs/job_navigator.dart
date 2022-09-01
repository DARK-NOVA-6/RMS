import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/entities.dart';
import '../nav_bar_pages/pages.dart';

class JobNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorState;
  final String tabItem;

  const JobNavigator({
    Key? key,
    required this.navigatorState,
    required this.tabItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (tabItem) {
      case 'Recommended':
        child = Recommended(job: createJob());
        break;
      case 'Unavailable':
        child = Unavailable(job: createJob());
        break;
      case 'Applied':
        child = Applied(job: createJob());
        break;
      default:
        child = const ErrorPage();
        break;
    }
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('error'),
    );
  }
}

Job createJob() {
  return Job(
    id: '1',
    companyName: 'Company Name',
    jobDescription: const JobDescription(
      title: 'Job Title',
      eduQualification: [
        DescriptionField(value: 'edu1', isRequired: false),
        DescriptionField(value: 'edu2', isRequired: false)
      ],
      experience: [
        DescriptionField(value: 'exp1', isRequired: false),
        DescriptionField(value: 'exp2', isRequired: false)
      ],
      languages: [
        DescriptionField(value: 'languages1', isRequired: false),
        DescriptionField(value: 'languages2', isRequired: false)
      ],
      skills: [
        DescriptionField(value: 'skills1', isRequired: false),
        DescriptionField(value: 'skills2', isRequired: false),
        DescriptionField(value: 'skills3', isRequired: false)
      ],
      summary: 'summary sum mary summary summary summary'
          'asddddddddddddddd   ddddddddddddd   ddddddddddddddddddddddddddd'
          'asddddddddddd   ddddddddddd   ddddddddddd ddddddasdddddddddas'
          'asdasdas   dasdasdasdas   dasdasdasdasdasd',
    ),
    publishedTime: Timestamp.now(),
  );
}
