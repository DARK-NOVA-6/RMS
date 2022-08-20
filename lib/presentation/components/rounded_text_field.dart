import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key? key,
    required this.controller,
    this.pass = false,
    this.email = false,
    this.code = false,
    this.icon = Icons.person,
    this.color = Colors.blue,
    this.secColor = Colors.white,
    this.hintText = 'input here',
    this.w = 0.7,
    this.h = 0.06,
  }) : super(key: key);
  final TextEditingController controller;
  final bool pass,email,code;
  final IconData icon;
  final Color color,secColor;
  final String hintText;
  final double w,h;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 15),
      width: size.width * w,
      height: size.height * h,
      child: Material(
        elevation: 20.0,
        color: color,
        shadowColor: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextFormField(
          keyboardType:
            (email == true)? TextInputType.emailAddress:
            (code == true)? TextInputType.number:null,
          inputFormatters: (code==true)?[
            LengthLimitingTextInputFormatter(6),
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ]:[],
          controller: controller,
          obscureText: pass,
          autofocus: false,
          style: const TextStyle(
            fontSize: 18,
          ),
          decoration: InputDecoration(
            icon: Icon(icon, color: secColor),
            hintText: hintText,
            fillColor: secColor,
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

