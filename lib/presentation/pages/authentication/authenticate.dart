import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login.dart';
import 'signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);
  final String title = 'Home';
  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final TextEditingController tecEmailSignUp = TextEditingController(),
      tecPassSignUp = TextEditingController(),
      tecEmailLogIn = TextEditingController(),
      tecPassLogIn = TextEditingController();
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
        centerTitle: true ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyElevatedButton(
              text:'Log In',
              press: () async {
                Navigator.of(context)
                  .push(
                    MaterialPageRoute(builder: (_) =>
                      LogIn(
                        tecEmailLogIn: tecEmailLogIn,
                        tecPassLogIn: tecPassLogIn,
                        tecEmailSignUp: tecEmailSignUp,
                        tecPassSignUp: tecPassSignUp,
                      )
                    )
                  );
                },
              w: 0.35,
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            MyElevatedButton(
              text:'Sign Up',
              press:() async {
                Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_) => SignUp(
                        tecEmailLogIn: tecEmailLogIn,
                        tecPassLogIn: tecPassLogIn,
                        tecEmailSignUp: tecEmailSignUp,
                        tecPassSignUp: tecPassSignUp,
                      )
                    )
                  );
                },
              w: 0.35,
            ),
            SizedBox(
              height: size.height*0.02,
            ),
          ],
        ),
      ),
    );
  }
}
