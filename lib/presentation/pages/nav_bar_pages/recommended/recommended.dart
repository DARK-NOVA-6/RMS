import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:untitled/domain/entities/job/evaluated_job.dart';
import 'package:untitled/domain/usecases/job/recommended/fetch_more.dart';

import '../../../../injection_container.dart';
import '../../../components/job/job.dart';
import '../common/common.dart';
import '../pages.dart';

class Recommended extends StatefulWidget implements Pages {
  const Recommended({Key? key}) : super(key: key);

  @override
  State<Recommended> createState() => _RecommendedState();

  @override
  String get label => 'Recommended';
}

class _RecommendedState extends State<Recommended> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();
  final FetchMoreRecommended fetcherRecommended = sl();
  List<EvaluatedJob> jobList = [];

  Future<void> _handleRefresh() async {
    _refreshIndicatorKey.currentState?.show();
    allLoaded = false;
    jobs.clear();
    fetcherRecommended.refresh();
    _handleProgress();
  }

  _handleProgress() async {
    if (allLoaded || loading) {
      return;
    }
    setState(() {
      loading = true;
    });

    List<EvaluatedJob> tmpJobs = await fetcherRecommended(limit: 3);
    jobList.addAll(tmpJobs);
    List<Widget> newJobs = tmpJobs.map((e) => JobWidget(job: e)).toList();
    if (newJobs.isNotEmpty) {
      jobs.addAll(Iterable.castFrom(newJobs));
    }

    setState(() {
      loading = false;
      allLoaded = newJobs.length < 3;
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
