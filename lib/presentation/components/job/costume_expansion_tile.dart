import 'package:flutter/material.dart';
import 'package:untitled/domain/entities/job/evaluated_job.dart';

import '../../pages/jobs/job_elements/bullet_point.dart';
import '../../../provider/theme.dart';

// ignore: must_be_immutable
class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile({
    Key? key,
    required this.job,
  }) : super(key: key);

  TextStyle fontSize_18 = const TextStyle(
    fontSize: 18,
  );
  final EvaluatedJob job;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      subtitle: Text(
        'For more details Press on the Job Title',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).primaryColor.withOpacity(0.7),
        ),
      ),
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.all(20).copyWith(top: 0),
      tilePadding: const EdgeInsets.only(left: 0),
      leading: const Icon(
        Icons.info_outline,
        size: 26,
      ),
      textColor: CustomeTheme.c1,
      title: Text(
        'Jop Details :',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Educational Qualifications:',
            style: fontSize_18.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: job.eduQualifications
                .map(
                  (item) => Row(
                    children: [
                      const MyBullet(),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          '${item.degree} - ${item.field}'
                          ' ${(item.isRequired) ? '(*)' : ''}',
                          style: fontSize_18.copyWith(
                              color: (!item.isSatisfied) ? Colors.red : null),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Experiences:',
            style: fontSize_18.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: job.experiences
                .map(
                  (item) => Row(
                    children: [
                      const MyBullet(),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          '${item.title} - ${item.period} Years'
                          ' ${(item.isRequired) ? '(*)' : ''}',
                          style: fontSize_18.copyWith(
                              color: (!item.isSatisfied) ? Colors.red : null),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Skills:',
            style: fontSize_18.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: job.skills
                .map(
                  (item) => Row(
                    children: [
                      const MyBullet(),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          '${item.title} ${(item.isRequired) ? '(*)' : ''}',
                          style: fontSize_18.copyWith(
                              color: (!item.isSatisfied) ? Colors.red : null),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Languages:',
            style: fontSize_18.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: job.languages
                .map(
                  (item) => Row(
                    children: [
                      const MyBullet(),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          '${item.title} ${(item.isRequired) ? '(*)' : ''}',
                          style: fontSize_18.copyWith(
                              color: (!item.isSatisfied) ? Colors.red : null),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
