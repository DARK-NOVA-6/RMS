import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = Colors.blueGrey,
    this.textColor = Colors.white,
    this.h = 0.05,
    this.w = 0.5,
  }) : super(key: key);

  final String text;
  final press;
  final Color color;
  final Color textColor;
  final double w,h;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)){
              return color.withAlpha(100);
            }
            return color; // Use the component's default.
          },
        ),
      ),
      onPressed: press,
      child: SizedBox(
        width: size.width * w,
        height: size.height * h,
        child:  Center(
          child: Text(text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
