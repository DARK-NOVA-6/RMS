import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';
import 'package:untitled/presentation/controllers/controllers.dart';

import '../../components/components.dart';
import '../../controllers/controllers.dart';

class LogIn extends StatefulWidget {
  const LogIn({
    Key? key,
    required this.controllers,
    this.popupWidget = const Center(),
    this.popup = false,
  }) : super(key: key);
  final String title = 'Log In';
  final Controllers controllers;
  final bool popup;
  final Widget popupWidget;

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.title,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedTextField(
              color: Theme.of(context).primaryColor,
              controller: widget.controllers.tecEmailLogIn,
              email: true,
              icon: Icons.mail,
              hintText: 'Email',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedTextField(
              color: Theme.of(context).primaryColor,
              controller: widget.controllers.tecPassLogIn,
              pass: true,
              icon: Icons.lock,
              hintText: 'Password',
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            MyElevatedButton(
              text: 'Log In',
              press: () async {
                BlocProvider.of<AuthBloc>(context).add(
                  LoginEvent(
                    email: widget.controllers.tecEmailLogIn.text,
                    password: widget.controllers.tecPassLogIn.text,
                  ),
                );
              },
              w: 0.35,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an Account",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(GetSignUpEvent());
                  },
                  child: const Text(
                    'Sign-up',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
