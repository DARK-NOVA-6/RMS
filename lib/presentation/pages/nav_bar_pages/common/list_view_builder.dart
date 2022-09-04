import 'package:flutter/material.dart';

import '../../../components/job/job.dart';
import 'refresh_box.dart';

// ignore: must_be_immutable
class ListViewBuilder extends StatelessWidget {
  ListViewBuilder({
    Key? key,
    required this.scrollController,
    this.jobsNotApplied,
    this.jobsApplied,
    required this.allLoaded,
    required this.onRefresh,
  }) : super(key: key);

  final Function() onRefresh;
  final ScrollController scrollController;
  List<JobWidget>? jobsNotApplied;
  List<AppliedJobWidget>? jobsApplied;
  final bool allLoaded;

  @override
  Widget build(BuildContext context) {
    var jobs = jobsApplied ?? jobsNotApplied;

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8),
      itemCount: jobs!.length + (allLoaded ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < jobs.length) {
          return jobs[index];
        } else {
          return RefreshBox(
            onRefresh: onRefresh,
            text: 'No more Jobs left to show!',
          );
        }
      },
    );
  }
}
