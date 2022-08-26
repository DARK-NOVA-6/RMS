import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../domain/entities/job/job.dart';
import '../../../components/job/job.dart';
import '../pages.dart';

class Applied extends StatefulWidget implements Pages {
  const Applied({Key? key,required this.job}) : super(key: key);
  final Job job;
  @override
  State<Applied> createState() => _AppliedState();

  @override
  String get label => 'Applied';
}

class _AppliedState extends State<Applied> {
  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      color: Theme.of(context).primaryColor.withAlpha(200),
      height: 200,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          JobWidget(
            job: widget.job,
          ),
          JobWidget(
            job: widget.job,
          ),
        ],
      ),
    );
  }
}
