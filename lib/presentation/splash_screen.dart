import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'bloc_builder_widget.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'controllers/controllers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.controllers,
  }) : super(key: key);

  final Controllers controllers;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthState init;

  @override
  void initState() {
    super.initState();
    init = AuthInitial();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      centered: true,
      animationDuration: const Duration(seconds: 1),
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      nextScreen: BlocBuilderWidget(
        controllers: widget.controllers,
        initialState: init,
      ),
      splashIconSize: 1600,
      splash: Image.asset('assets/png/Asset 1.png'),
    );
  }
}
