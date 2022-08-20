import 'package:flutter/material.dart';
import 'package:untitled/Pages/Authentication/SignUp.dart';
import 'package:untitled/Pages/Authentication/LogIn.dart';

import '../../Components/MyElevatedButton.dart';

class Authinticate extends StatefulWidget {
  const Authinticate({Key? key}) : super(key: key);
  final String title = 'Home';
  @override
  State<Authinticate> createState() => _AuthinticateState();
}

class _AuthinticateState extends State<Authinticate> {
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
