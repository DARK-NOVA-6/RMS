import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/theme.dart';

import '../provider/theme_notifier.dart';
import 'bloc_builder_widget.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'controllers/controllers.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
    required this.authBloc,
    required this.controllers,
  }) : super(key: key);

  final AuthBloc authBloc;
  final Controllers controllers;

  @override
  Widget build(BuildContext context) {
    AuthState init = AuthInitial();
    return BlocProvider.value(
      value: authBloc,
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier themeNotifier, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'RMS Demo pla....',
              theme: themeNotifier.darkTheme
                  ? CustomeTheme.dark
                  : CustomeTheme.light,
              home: BlocBuilderWidget(
                controllers: controllers,
                initialState: init,
              ),
            );
          },
        ),
      ),
    );
  }
}
