
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/domain/entities/job/applied_job.dart';
import 'package:untitled/domain/usecases/job/applied/add_inquiry_applied.dart';
import 'package:untitled/presentation/components/components.dart';
import 'package:untitled/presentation/pages/jobs/job_elements/job_questions.dart';

import '../../../domain/usecases/job/applied/cancel_application.dart';
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
            onPressed: () {
              CancelApplication()(
                appliedId: ejob.appliedId,
                jobId: ejob.jobId,
              );
              Navigator.pop(context, true);
            },
            child: Row(
              children: const [
                Text(
                  'Cancel',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: MyElevatedButton(
                text: 'show notes',
                press: () {
                  showNotes(context, setState);
                },
              ),
            ),
            Tile(text1: 'State', text2: ejob.state, indent: false),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: MyElevatedButton(
                text: 'show inquiries',
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => JobQuestions(ejob: ejob),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showNotes(BuildContext context, setState) {
    String value = ejob.state;

    Map<String, List<String>> notes = {};
    for (var e in ejob.notes) {
      if (notes[e.state] == null) {
        notes[e.state] = [];
      }
      notes[e.state]!.add(e.note);
    }

    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                  .copyWith(bottom: 0),
          actionsPadding: const EdgeInsets.all(10).copyWith(top: 0),
          actions: [
            DialogButton(
              onPress: () => Navigator.pop(context),
              text: 'Ok',
            ),
          ],
          title: const Text('Select a state to show notes'),
          titleTextStyle:
              (Theme.of(context).textTheme.headline6)?.copyWith(fontSize: 20),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RoundedDropdownButton(
                  icon: Icons.work_history,
                  label: 'State',
                  enabled: true,
                  list: const [
                    'all',
                    'screening',
                    'reviewing',
                    'interviewing',
                    'rejected',
                    'hired',
                  ],
                  value: value,
                  color: Theme.of(context).primaryColor,
                  valueChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: ListView(
                    children: [
                      if (notes.isEmpty ||
                          (value != 'all' &&
                              (notes[value] == null ||
                                  notes[value]!.isEmpty))) ...[
                        const SizedBox(height: 30),
                        Image.asset('assets/png/Asset 2.png', height: 100),
                        const SizedBox(height: 20),
                        Center(
                          child: ListTile(
                            title: Text(
                              'No Notes in $value state',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                      if (notes.isNotEmpty) ...[
                        if (value == 'all')
                          ...ejob.notes.map((e) {
                            return ListTile(
                              title: Text(
                                e.state,
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                e.note,
                                style: const TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        if (value != 'all')
                          ...(notes[value] != null)
                              ? notes[value]!.map(
                                  (e) => ListTile(
                                    title: Text(
                                      e,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                )
                              : [],
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    Key? key,
    required this.onPress,
    required this.text,
  }) : super(key: key);

  final String text;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
