import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/domain/entities/job/applied_job.dart';

import 'job_elements/job_elements.dart';

class AppliedJobDetails extends StatefulWidget {
  const AppliedJobDetails({Key? key, required this.eJob}) : super(key: key);

  final AppliedJob eJob;

  @override
  State<AppliedJobDetails> createState() => _AppliedJobDetailsState();
}

class _AppliedJobDetailsState extends State<AppliedJobDetails> {
  late List<Triple> text;
  late AppliedJob ejob;

  beforeBuild() {
    ejob = widget.eJob;
    text = [
      Triple('Company :', ejob.companyName),
      Triple(
        'Publish Date :',
        DateFormat.yMMMd().format(ejob.appliedTime.toDate()),
      ),
      Triple('Summery :', ''),
      Triple('.', ejob.summary),
    ];
    text.add(Triple('Educational Qualifications :', ''));
    if (ejob.eduQualifications.isEmpty) {
      text.add(Triple(
        '',
        'No Qualifications Required',
        indent: true,
      ));
    }

    for (var element in ejob.eduQualifications) {
      text.add(Triple(
        'Degree - Field${element.isRequired ? '(required)' : ''} :',
        '',
        indent: true,
      ));
      text.add(Triple(
        '',
        '${element.degree} - ${element.field}',
        indent: true,
        isSatisfied: element.isSatisfied,
      ));
      text.add(Triple('', ''));
    }
    text.add(Triple('Past Experiences:', ''));
    if (ejob.experiences.isEmpty) {
      text.add(Triple(
        '',
        'No Experiences Required',
        indent: true,
      ));
    }
    for (var element in ejob.experiences) {
      text.add(Triple(
        'Job Title${element.isRequired ? '(required)' : ''} :',
        '',
        indent: true,
      ));
      text.add(Triple(
        '',
        element.title,
        indent: true,
        isSatisfied: element.isSatisfied,
      ));
      text.add(Triple(
        'Period${element.isRequired ? '(required)' : ''} :',
        '',
        indent: true,
        isSatisfied: element.isSatisfied,
      ));
      text.add(Triple(
        '',
        '${element.period} Years',
        indent: true,
        isSatisfied: element.isSatisfied,
      ));
      text.add(Triple('', ''));
    }
    text.add(Triple('Skills :', ''));
    if (ejob.skills.isEmpty) {
      text.add(Triple(
        '',
        'No Skills Required',
        indent: true,
      ));
    }
    text.addAll(
      ejob.skills.map(
        (e) => Triple(
          '#',
          e.title + (e.isRequired ? '*' : ''),
          indent: true,
          isSatisfied: e.isSatisfied,
        ),
      ),
    );
    text.add(Triple('Languages :', ''));
    if (ejob.languages.isEmpty) {
      text.add(Triple(
        '',
        'No Languages Required',
        indent: true,
      ));
    }
    text.addAll(
      ejob.languages.map(
            (e) => Triple(
          '#',
          e.title + (e.isRequired ? '*' : ''),
          indent: true,
          isSatisfied: e.isSatisfied,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    beforeBuild();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.add_circle_outline,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          ejob.title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) => Tile(
                isSatisfied: text[index].isSatisfied,
                indent: text[index].indent,
                text1: text[index].left,
                text2: text[index].right,
              ),
              itemCount: text.length,
            )
          ],
        ),
      ),
    );
  }
}
