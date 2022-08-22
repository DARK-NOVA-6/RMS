import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';

import '../../components/components.dart';
import '../home/home.dart';
import 'signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({
    Key? key,
    required this.tecEmailLogIn,
    required this.tecPassLogIn,
    required this.tecEmailSignUp,
    required this.tecPassSignUp,
    this.popup = false,
    this.popupText = '',
    this.popupActions = const [],
    this.popupOnPressActions = const [],
  }) : super(key: key);
  final String title = 'Log In';
  final TextEditingController tecEmailLogIn,
      tecPassLogIn,
      tecEmailSignUp,
      tecPassSignUp;

  final bool popup;
  final String popupText;
  final List<String> popupActions;
  final List popupOnPressActions;
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
              controller: widget.tecEmailLogIn,
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
              controller: widget.tecPassLogIn,
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
              text: 'Log In',
              press: () async {
                Navigator.of(context).popUntil((route) => false);
                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const Home()));
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
                    // await Navigator.of(context)
                    //     .push(
                    //     MaterialPageRoute(builder: (_) =>
                    //         SignUp(
                    //           tecEmailSignUp: widget.tecEmailSignUp,
                    //           tecPassSignUp: widget.tecPassSignUp,
                    //           tecEmailLogIn: widget.tecEmailLogIn,
                    //           tecPassLogIn: widget.tecPassLogIn,
                    //         )
                    //     )
                    // );
                    // ignore: use_build_context_synchronously
                    // Navigator.of(context).pop();
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
