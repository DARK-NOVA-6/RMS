import 'package:flutter/material.dart';
import 'package:untitled/Pages/Authentication/Authenticate.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'RMS',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Authinticate(),
    );
  }
}




