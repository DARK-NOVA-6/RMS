import 'package:flutter/material.dart';
import '../../../components/job/job.dart';
import 'refresh_box.dart';

class ListViewBuilder extends StatelessWidget {
  const ListViewBuilder({
    Key? key,
    required this.scrollController,
    required this.jobs,
    required this.allLoaded,
    required this.onRefresh,
  }) : super(key: key);

  final Function() onRefresh;
  final ScrollController scrollController;
  final List<JobWidget> jobs;
  final bool allLoaded;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(8),
      itemCount: jobs.length + (allLoaded ? 1 : 0),
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
