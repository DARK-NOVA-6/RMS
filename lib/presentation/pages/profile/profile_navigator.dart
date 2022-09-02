import 'package:flutter/material.dart';
import 'package:untitled/presentation/controllers/controllers.dart';

import 'tabs/tabs.dart';

class ProfileNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorState;
  final String tabItem;
  final UserController userController;

  const ProfileNavigator({
    Key? key,
    required this.userController,
    required this.navigatorState,
    required this.tabItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (tabItem) {
      case 'personal':
        child = PersonalInformation(
          personalControllers: userController.personalControllers,
        );
        break;
      case 'edu':
        child = EducationalQualifications(
          eduControllers: userController.eduControllers,
        );
        break;
      case 'exp':
        child = PastExperiences(
          expControllers: userController.expControllers,
        );
        break;
      case 'skills':
        child = Skills(
          skillsControllers: userController.skillsControllers,
        );
        break;
      case 'lang':
        child = Languages(
          languagesControllers: userController.languagesControllers,
        );
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
