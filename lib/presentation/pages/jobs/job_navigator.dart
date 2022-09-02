import 'package:flutter/material.dart';

import '../nav_bar_pages/pages.dart';

class JobNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorState;
  final String tabItem;

  const JobNavigator({
    Key? key,
    required this.navigatorState,
    required this.tabItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (tabItem) {
      case 'Recommended':
        child = const Recommended();
        break;
      case 'Unavailable':
        child = const Unavailable();
        break;
      case 'Applied':
        child = const Applied();
        break;
      default:
        child = const ErrorPage();
        break;
    }
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('error'),
    );
  }
}
