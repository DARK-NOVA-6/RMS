import 'package:flutter/material.dart';

import 'presentation/pages/authentication/authenticate.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'RMS Demo pla....',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Authenticate(),
    );
  }
}




