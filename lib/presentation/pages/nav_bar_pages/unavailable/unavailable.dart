import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:untitled/domain/usecases/job/unavailable/fetch_more.dart';

import '../../../../domain/entities/job/evaluated_job.dart';
import '../../../components/job/job.dart';
import '../common/common.dart';
import '../pages.dart';

class Unavailable extends StatefulWidget implements Pages {
  const Unavailable({Key? key}) : super(key: key);

  @override
  State<Unavailable> createState() => _UnavailableState();

  @override
  String get label => 'Unavailable';
}

class _UnavailableState extends State<Unavailable> {
  ScrollController scrollController = ScrollController();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();
  final FetchMoreUnavailable fetchMoreUnavailable = FetchMoreUnavailable();
  List<EvaluatedJob> jobList = [];

  Future<void> _handleRefresh() async {
    _refreshIndicatorKey.currentState?.show();
    allLoaded = false;
    jobs.clear();
    fetchMoreUnavailable.refresh();
    _handleProgress();
  }

  _handleProgress() async {
    if (allLoaded || loading) {
      return;
    }
    setState(() {
      loading = true;
    });

    List<EvaluatedJob> tmpJobs = await fetchMoreUnavailable(limit: 3);
    jobList.addAll(tmpJobs);
    List<Widget> newJobs = tmpJobs
        .map((e) => JobWidget(
              job: e,
              callParent: () {},
            ))
        .toList();
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
                  jobsNotApplied: jobs,
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
                  text: 'There is no Jobs here right now !!',
                  subText: 'Try again later',
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
