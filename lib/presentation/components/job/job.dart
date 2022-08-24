import 'package:flutter/material.dart';
import '../../../domain/entities/entities.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';

import 'costum_expansion_tile.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                onPressed: () {},
                child: Text(
                  job.companyName,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat.yMMMEd().format(job.publishedTime.toDate()),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Center(
              child: Text(
                job.jobDescription.title,
                style: const TextStyle(fontSize: 22, color: Colors.black54),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ReadMoreText(
              job.jobDescription.summary,
              trimMode: TrimMode.Line,
              trimLines: 3,
              style: const TextStyle(fontSize: 16),
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
          CustomExpansionTile(job: job),
        ],
      ),
    );
  }
}
