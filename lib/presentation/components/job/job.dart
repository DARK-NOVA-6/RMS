import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.redAccent,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12).copyWith(bottom: 0),
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
              Text(DateFormat.yMMMEd().format(job.publishedTime.toDate())),
            ],
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                job.jobDescription.title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Container(
            child: ReadMoreText(
              job.jobDescription.summary,
              trimMode: TrimMode.Line,
              trimLines: 3,
              lessStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 18,
              ),
              moreStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 18,
              ),
              trimExpandedText: ' show less',
            ),
          ),
          ExpansionTile(
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.all(20).copyWith(top: 0),
            tilePadding: const EdgeInsets.only(left: 0),
            leading: const Icon(
              Icons.info_outline,
              color: Colors.redAccent,
            ),
            title: const Text('Job Details:'),
            children: [
              const Text('Educational Qualification:'),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: job.jobDescription.eduQualification
                      .map((item) => Text(item))
                      .toList(),
                ),
              ),
              const Text('Experience:'),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: job.jobDescription.experience
                      .map((item) => Text(item))
                      .toList(),
                ),
              ),
              const Text('Skills:'),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: job.jobDescription.skills
                      .map((item) => Text(item))
                      .toList(),
                ),
              ),
              const Text('Languages:'),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: job.jobDescription.languages
                      .map((item) => Text(item))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
