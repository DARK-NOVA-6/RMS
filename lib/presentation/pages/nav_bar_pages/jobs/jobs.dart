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
        eduQualification: ['edu1','edu2'],
        experience: ['exp1','exp2'],
        languages: ['languages1','languages2'],
        skills: ['skills1','skills2','skills3'],
        summary: 'summary summary summary summary summary',
      ),
      publishedTime: DateTime.now(),
  );
  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: const  Duration(milliseconds: 600),
      child: Scaffold(
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
            Center(
              child: JobWidget(
                job: widget.job,
              ),
            ),
            const Center(child: Text('Unavailable')),
            const Center(child: Text('Applied')),
          ],
        ),
      ),
    );
  }
}
