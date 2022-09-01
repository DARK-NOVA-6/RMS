import 'package:flutter/material.dart';

import 'tabs/tabs.dart';

class ProfileNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorState;
  final String tabItem;

  const ProfileNavigator({
    Key? key,
    required this.navigatorState,
    required this.tabItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (tabItem) {
      case 'personal':
        child = const PersonalInformation();
        break;
      case 'edu':
        child = const EducationalQualifications();
        break;
      case 'exp':
        child = const PastExperiences();
        break;
      case 'skills':
        child = const Skills();
        break;
      case 'lang':
        child = const Languages();
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
