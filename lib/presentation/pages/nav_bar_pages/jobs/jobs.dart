import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/presentation/components/job/job.dart';

import '../../../../domain/entities/entities.dart';
import '../pages.dart';

// ignore: must_be_immutable
class Jobs extends StatefulWidget implements Pages {
  Jobs({Key? key}) : super(key: key);

  @override
  String get label => 'Jobs';

  Job job = Job(
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

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: const Duration(milliseconds: 600),
      child: Scaffold(
        extendBody: true,
        appBar: const TabBar(
          labelColor: Colors.redAccent,
          isScrollable: true,
          labelStyle: TextStyle(
            fontSize: 20,
          ),
          tabs: <Widget>[
            Tab(text: 'Recommended'),
            Tab(text: 'Unavailable'),
            Tab(text: 'Applied'),
          ],
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(8),
              children: [
                JobWidget(
                  job: widget.job,
                ),
                JobWidget(
                  job: widget.job,
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(8),
              children: [
                JobWidget(
                  job: widget.job,
                ),
                JobWidget(
                  job: widget.job,
                ),
                JobWidget(
                  job: widget.job,
                ),
                JobWidget(
                  job: widget.job,
                ),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(8),
              children: [
                JobWidget(
                  job: widget.job,
                ),
                JobWidget(
                  job: widget.job,
                ),
                JobWidget(
                  job: widget.job,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
