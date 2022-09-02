import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../domain/entities/job/evaluated_job.dart';
import '../../../../domain/usecases/job/unavailable/fetch_more.dart';
import '../../../../injection_container.dart';
import '../../../components/job/job.dart';
import '../common/common.dart';
import '../pages.dart';

class Applied extends StatefulWidget implements Pages {
  const Applied({Key? key}) : super(key: key);

  @override
  State<Applied> createState() => _AppliedState();

  @override
  String get label => 'Applied';
}

class _AppliedState extends State<Applied> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();
  final FetchMoreUnavailable fetchMoreUnavailable = FetchMoreUnavailable();
  List<EvaluatedJob> jobList = [];

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
    jobList.addAll(await fetchMoreUnavailable(limit: 1));
    List<Widget> newJobs = jobList.map((e) => JobWidget(job: e)).toList();
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
          if (loading || jobs.isNotEmpty) {
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
                  text: 'There is no Jobs !!',
                  subText: 'Try Applying to some job then try again',
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
