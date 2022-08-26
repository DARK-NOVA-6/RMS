import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../domain/entities/job/job.dart';
import '../../../components/job/job.dart';
import '../pages.dart';

class Recommended extends StatefulWidget implements Pages {
  const Recommended({Key? key, required this.job}) : super(key: key);
  final Job job;

  @override
  State<Recommended> createState() => _RecommendedState();

  @override
  String get label => 'Recommended';
}

class _RecommendedState extends State<Recommended> {
  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 2));
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
