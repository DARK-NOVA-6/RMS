import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/presentation/blocs/authentication/auth_bloc.dart';

import '../../components/components.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);
  final String title = 'Home';

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
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
            MyElevatedButton(
              text: 'Log In',
              press: () {
                BlocProvider.of<AuthBloc>(context).add(GetSignInEvent());
              },
              w: 0.35,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            MyElevatedButton(
              text: 'Sign Up',
              press: () {
                BlocProvider.of<AuthBloc>(context).add(GetSignUpEvent());
              },
              w: 0.35,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
