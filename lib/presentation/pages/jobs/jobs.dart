import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/entities.dart';
import '../../components/components.dart';
import '../nav_bar_pages/pages.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  late List pages;

  @override
  void initState() {
    super.initState();
    pages = [
      Recommended(job: job),
      Unavailable(job: job),
      Applied(job: job),
    ];
  }

  int index = 0;
  List<Widget> icons = const [
    Icon(Icons.add_task_outlined),
    Icon(Icons.unpublished),
    Icon(Icons.event_available_outlined),
  ];

  Job job = createJob();

  void changeIndex(int value) {
    setState(() {
      index = value;
    });
  }

  List<Widget> actions = [
    Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        icon: const Icon(
          Icons.notifications,
          size: 30,
        ),
        onPressed: () {},
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavBar(
        index: index,
        changeIndex: changeIndex,
        icons: icons,
      ),
      appBar: CustomeAppBar(label: pages[index].label, actions: actions),
      body: pages[index],
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
