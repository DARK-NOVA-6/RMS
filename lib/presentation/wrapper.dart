import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc_builder_widget.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'controllers/controllers.dart';

import '../domain/entities/user.dart' as user_ent;

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

    print(Provider.of<user_ent.User>(context));
    return BlocProvider.value(
      value: authBloc,
      child: MaterialApp(
        title: 'RMS Demo pla....',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: BlocBuilderWidget(
          controllers: controllers,
          initialState: init,
        ),
      ),
    );
  }
}
