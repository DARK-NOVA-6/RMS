import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/pages/profile/profile_navigator.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import '../../components/components.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int currentIndex = 0;
  String currentPage = 'personal';
  List<String> pagesKeys = ['personal', 'edu', 'exp', 'skills', 'lang'];
  Map<String, GlobalKey<NavigatorState>> navigatorState = {
    'personal': GlobalKey<NavigatorState>(),
    'edu': GlobalKey<NavigatorState>(),
    'exp': GlobalKey<NavigatorState>(),
    'skills': GlobalKey<NavigatorState>(),
    'lang': GlobalKey<NavigatorState>(),
  };
  final List<Text> texts = [
    const Text('Personal Information', style: TextStyle(fontSize: 20)),
    const Text(
      'Educational Qualifications',
      style: TextStyle(fontSize: 20),
    ),
    const Text('Past Experience', style: TextStyle(fontSize: 20)),
    const Text('Skills', style: TextStyle(fontSize: 20)),
    const Text('Languages', style: TextStyle(fontSize: 20)),
  ];
  late List<Widget> actions1;
  late List<Widget> actions2;

  @override
  void initState() {
    super.initState();
    actions2 = [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            Icons.edit,
            size: 30,
          ),
          onPressed: () {
            Provider.of<UpdateActionBarActions>(context, listen: false)
                .changeEditMode(true);
          },
        ),
      ),
    ];
    actions1 = [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            Icons.published_with_changes_outlined,
            size: 30,
          ),
          onPressed: () {
            Provider.of<UpdateActionBarActions>(context, listen: false)
                .changeEditMode(false);
          },
        ),
      ),
    ];
  }

  void selectTab(int index) {
    if (currentPage == pagesKeys[index]) {
      navigatorState[index]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pagesKeys[index];
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        initialIndex: currentIndex,
        length: pagesKeys.length,
        child: WillPopScope(
          onWillPop: () async {
            final isFirstRouteInCurrentTab =
                !await navigatorState[currentPage]!.currentState!.maybePop();
            if (isFirstRouteInCurrentTab) {
              if (currentPage != 'personal') {
                selectTab(1);
              }
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            appBar: CustomeAppBar(
              label: 'Profile',
              actions1: actions1,
              actions2: actions2,
            ),
            body: Scaffold(
              appBar: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                isScrollable: true,
                // padding: const EdgeInsets.only(top: 10),
                onTap: (value) => selectTab(value),
                tabs: texts,
              ),
              body: Stack(
                children: pagesKeys
                    .map(
                      (e) => buildOffstageNavigator(e),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: ProfileNavigator(
        navigatorState: navigatorState[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
