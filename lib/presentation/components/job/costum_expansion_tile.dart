import 'package:flutter/material.dart';
import 'package:untitled/provider/theme.dart';
import '../../../domain/entities/entities.dart';

// ignore: must_be_immutable
class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile({
    Key? key,
    required this.job,
  }) : super(key: key);

  TextStyle fontSize_18 = const TextStyle(
    fontSize: 18,
  );
  final Job job;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.all(20).copyWith(top: 0),
      tilePadding: const EdgeInsets.only(left: 0),
      leading: const Icon(
        Icons.info_outline,
      ),
      textColor: CustomeTheme.c1,
      title: Text(
        'Job Details:',
        style: TextStyle(
          fontSize: 20,
          color: Theme.of(context).primaryColor,
        ),
      ),
      children: [
        Text('Educational Qualification:', style: fontSize_18),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: job.jobDescription.eduQualification
                .map((item) => Text(item.value, style: fontSize_18))
                .toList(),
          ),
        ),
        Text('Experience:', style: fontSize_18),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: job.jobDescription.experience
                .map((item) => Text(item.value, style: fontSize_18))
                .toList(),
          ),
        ),
        Text('Skills:', style: fontSize_18),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: job.jobDescription.skills
                .map((item) => Text(item.value, style: fontSize_18))
                .toList(),
          ),
        ),
        Text('Languages:', style: fontSize_18),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: job.jobDescription.languages
                .map((item) => Text(item.value, style: fontSize_18))
                .toList(),
          ),
        ),
      ],
    );
  }
}
