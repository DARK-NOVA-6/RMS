import 'package:flutter/material.dart';

import '../../components/components.dart';


class Confirmation extends StatefulWidget {
  const Confirmation({Key? key,required this.tec}) : super(key: key);
  final String title = 'Confirm Email';
  final TextEditingController tec;

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  late TextEditingController tecEmailSignUp;
  TextEditingController tecCCode = TextEditingController();
  @override
  void initState() {
    super.initState();
    tecEmailSignUp = widget.tec;
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: const Text(
                'We send a 6-digits Verification Code to your Email:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                tecEmailSignUp.text,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.04,
            ),
            RoundedTextField(
              controller: tecCCode,
              code: true,
              icon: Icons.code,
              color: Colors.blueGrey,
              secColor: Colors.white,
              hintText: 'Verification Code',
            ),
            SizedBox(
              height: size.height*0.04,
            ),
            MyElevatedButton(
              text:'Submit',
              press:(){},
              w: 0.35,
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            MyElevatedButton(
              text:'Resend',
              press:(){},
              w: 0.20,
            ),
          ],
        ),
      ),
    );
  }
}

