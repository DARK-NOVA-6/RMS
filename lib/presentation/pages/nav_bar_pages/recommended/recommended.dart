import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../domain/entities/job/job.dart';
import '../../../components/job/job.dart';
import '../common/common.dart';
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
  ScrollController scrollController = ScrollController();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();

  Future<void> _handleRefresh() async {
    _refreshIndicatorKey.currentState?.show();
    allLoaded = false;
    jobs.clear();
    return await Future.delayed(const Duration(seconds: 2));
  }

  _handleProgress() async {
    if (allLoaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    List<Widget> newJobs = jobs.length >= 3
        ? []
        : List.generate(
            3,
            (index) => JobWidget(
              job: widget.job,
            ),
          );
    if (newJobs.isNotEmpty) {
      jobs.addAll(Iterable.castFrom(newJobs));
    }
    setState(() {
      loading = false;
      allLoaded = newJobs.isEmpty;
    });
  }

  @override
  initState() {
    super.initState();
    _handleProgress();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !loading) {
        _handleProgress();
      }
    });
  }

  @override
  dispose() {
    super.dispose();
    scrollController.dispose();
  }

  List<JobWidget> jobs = [];
  bool loading = false, allLoaded = false;

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      color: Theme.of(context).primaryColor.withAlpha(200),
      height: 200,
      springAnimationDurationInMilliseconds: 300,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (loading||jobs.isNotEmpty) {
            return Stack(
              children: [
                ListViewBuilder(
                  onRefresh: _handleRefresh,
                  scrollController: scrollController,
                  jobs: jobs,
                  allLoaded: allLoaded,
                ),
                if (loading) ...[
                  const Loader(),
                ],
              ],
            );
          } else {
            return Column(
              children: [
                const Spacer(flex: 5),
                RefreshBox(
                  onRefresh: _handleRefresh,
                  text: 'There is no Jobs recommended for you right now !!',
                  subText: 'Try enhancing your profile and try again',
                ),
                const Spacer(flex: 5),
              ],
            );
          }
        },
      ),
    );
  }
}
