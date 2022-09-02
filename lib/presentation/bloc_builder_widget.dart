import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/components/components.dart';

import 'Pages/Authentication/authenticate.dart';
import 'Pages/Authentication/login.dart';
import 'Pages/Authentication/signup.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'controllers/controllers.dart';

class BlocBuilderWidget extends StatelessWidget {
  const BlocBuilderWidget({
    Key? key,
    required this.controllers,
    required this.initialState,
  }) : super(key: key);

  final Controllers controllers;
  final AuthState initialState;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpErrorState) {
          print(state.message);
        } else if (state is SignInErrorState) {
          print(state.message);
        } else if (state is SignedUpState) {
          print('new account has been registered ');
        } else if (state is SignedUpState) {
          print('welcome ');
        } else if (state is AuthInitial) {
          print('initial');
        }
      },
      builder: (context, state) {
        if (state is AuthInitial) {
          return const Authenticate();
        } else if (state is SigningInState) {
          return LogIn(
            controllers: controllers,
          );
        } else if (state is SignedInState) {
          controllers.tecEmailLogIn.text = '';
          controllers.tecPassLogIn.text = '';
          return const CustomeZoomDrawer();
        } else if (state is SignInErrorState) {
          return LogIn(
            controllers: controllers,
            // hasPopup: true,
            // popupWidget: Popup(),
          );
        } else if (state is SigningUpState) {
          return SignUp(
            controllers: controllers,
          );
        } else if (state is SignedUpState) {
          return SignUp(
            controllers: controllers,
            // hasPopup: true,
            // popupWidget: Popup(),
          );
        } else if (state is SignUpErrorState) {
          return SignUp(
            controllers: controllers,
            // hasPopup: true,
            // popupWidget: Popup(),
          );
        } else if (state is Loading) {
          return const Text('Wait for it!!');
        } else {
          return const Text('unexpected state!');
        }
      },
    );
  }
}
