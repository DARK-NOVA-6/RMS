import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'job_navigator.dart';

// ignore: must_be_immutable
class Jobs extends StatefulWidget {
  Jobs({Key? key}) : super(key: key) {
    currentIndex = 0;
    currentPage = 'Recommended';
    pagesKeys = ['Recommended', 'Unavailable', 'Applied'];
    navigatorState = {
      'Recommended': GlobalKey<NavigatorState>(),
      'Unavailable': GlobalKey<NavigatorState>(),
      'Applied': GlobalKey<NavigatorState>(),
    };
  }

  late String currentPage;
  late int currentIndex;
  late List<String> pagesKeys;
  late Map<String, GlobalKey<NavigatorState>> navigatorState;

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> icons = const [
    Icon(Icons.add_task_outlined),
    Icon(Icons.unpublished),
    Icon(Icons.event_available_outlined),
  ];

  List<Widget> actions = [
    Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        icon: const Icon(
          Icons.notifications,
          size: 30,
        ),
        onPressed: () {},
      ),
    ),
  ];

  void selectTab(int index) {
    if (widget.currentPage == widget.pagesKeys[index]) {
      widget.navigatorState[widget.currentPage]!.currentState!
          .popUntil((route) {
        return route.isFirst;
      });
    } else {
      setState(() {
        widget.currentPage = widget.pagesKeys[index];
        widget.currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool first = !await widget
            .navigatorState[widget.currentIndex]!.currentState!
            .maybePop();
        if (first) {
          if (widget.currentPage == 'Recommended') {
            selectTab(0);
            return false;
          }
        }
        return first;
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavBar(
          index: widget.currentIndex,
          changeIndex: selectTab,
          icons: icons,
        ),
        appBar: CustomeAppBar(
          label: widget.pagesKeys[widget.currentIndex],
          actions: actions,
        ),
        body: Stack(
          children:
              widget.pagesKeys.map((e) => buildOffstageNavigator(e)).toList(),
        ),
      ),
    );
  }

  Widget buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: widget.currentPage != tabItem,
      child: JobNavigator(
        navigatorState: widget.navigatorState[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
