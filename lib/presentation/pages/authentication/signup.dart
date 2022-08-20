import 'package:flutter/material.dart';

import '../../components/my_elevated_button.dart';
import '../../components/rounded_text_field.dart';
import 'confirmation_code.dart';
import 'login.dart';


class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
    required this.tecEmailSignUp,
    required this.tecPassSignUp,
    required this.tecEmailLogIn,
    required this.tecPassLogIn,
  }) : super(key: key);
  final String title = 'Sign Up';
  final TextEditingController tecEmailLogIn, tecPassLogIn,
      tecEmailSignUp, tecPassSignUp;
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
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedTextField(
              controller: widget.tecEmailSignUp,
              email: true,
              icon: Icons.mail,
              color: Colors.blueGrey,
              secColor: Colors.white,
              hintText: 'Email',
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            RoundedTextField(
              controller: widget.tecPassSignUp,
              pass: true,
              icon:Icons.lock,
              color: Colors.blueGrey,
              secColor: Colors.white,
              hintText: 'Password',
            ),
            SizedBox(
              height: size.height*0.04,
            ),
            MyElevatedButton(
              text:'Sign Up',
              press:() async {
                await Navigator.of(context)
                  .push(
               MaterialPageRoute(builder: (_) =>
                          Confirmation(
                            tec: widget.tecEmailSignUp,
                          )
                      )
                  );
              },
              w: 0.35,
            ),
            SizedBox(
              height: size.height*0.02,
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
                  onPressed: () async {
                    await Navigator.of(context)
                        .push(
                          MaterialPageRoute(builder: (_) =>
                            LogIn(
                              tecEmailSignUp: widget.tecEmailSignUp,
                              tecPassSignUp: widget.tecPassSignUp,
                              tecEmailLogIn: widget.tecEmailLogIn,
                              tecPassLogIn: widget.tecPassLogIn,
                            )
                          )
                        );
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
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

