import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                job.companyName,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(job.publishedTime.toString()),
            ],
          ),
          Container(
            child: Text(
              job.jobDescription.title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Container(
            child: Text(job.jobDescription.summary),
          ),
          Container(
            child: const Text('Educational Qualification:'),
          ),
          Column(
            children: job.jobDescription.eduQualification
                .map((item) => Text(item))
                .toList(),
          ),
          Container(
            child: const Text('Experience:'),
          ),
          Column(
            children: job.jobDescription.experience
                .map((item) => Text(item))
                .toList(),
          ),
          Container(
            child: const Text('Skills:'),
          ),
          Column(
            children:
                job.jobDescription.skills
                    .map((item) => Text(item))
                    .toList(),
          ),
          Container(
            child: const Text('Languages:'),
          ),
          Column(
            children:
                job.jobDescription.languages
                    .map((item) => Text(item))
                    .toList(),
          ),
        ],
      ),
    );
  }
}
