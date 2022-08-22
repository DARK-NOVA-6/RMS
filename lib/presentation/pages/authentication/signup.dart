import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/auth_bloc.dart';
import '../../components/components.dart';
import '../../controllers/controllers.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
    required this.controllers,
    this.popupWidget = const Center(),
    this.hasPopup = false,
  }) : super(key: key);
  final String title = 'Sign Up';
  final Controllers controllers;
  final bool hasPopup;
  final Widget popupWidget;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedTextField(
              controller: widget.controllers.tecEmailSignUp,
              email: true,
              icon: Icons.mail,
              color: Colors.redAccent,
              secColor: Colors.white,
              hintText: 'Email',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedTextField(
              controller: widget.controllers.tecPassSignUp,
              pass: true,
              icon: Icons.lock,
              color: Colors.redAccent,
              secColor: Colors.white,
              hintText: 'Password',
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            MyElevatedButton(
              text: 'Sign Up',
              press: () {
                BlocProvider.of<AuthBloc>(context).add(
                  SignUpEvent(
                    email: widget.controllers.tecEmailSignUp.text,
                    password: widget.controllers.tecPassSignUp.text,
                    confPassword: widget.controllers.tecConfPassSignUp.text,
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
                  'Already have an Account',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(
                      GetSignInEvent(),
                    );
                  },
                  child: const Text(
                    'Log-in',
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
