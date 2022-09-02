import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/job/evaluated_job.dart';
import 'job_elements/tile.dart';
import 'job_elements/triple.dart';

class JobDetails extends StatefulWidget {
  const JobDetails({Key? key, required this.eJob}) : super(key: key);

  final EvaluatedJob eJob;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  late List<Triple> text;
  late EvaluatedJob ejob;

  beforeBuild() {
    ejob = widget.eJob;
    text = [
      Triple('Company :', ejob.companyName),
      Triple(
        'Publish Date :',
        DateFormat.yMMMd().format(ejob.publishedTime.toDate()),
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
      ));
      text.add(Triple(
        'Period${element.isRequired ? '(required)' : ''} :',
        '',
        indent: true,
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
