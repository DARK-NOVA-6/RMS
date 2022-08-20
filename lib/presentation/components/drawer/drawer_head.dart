import 'package:flutter/material.dart';

class DrawerHead extends StatelessWidget {
  const DrawerHead({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.04,
              ),
              const Text(
                'LOGO',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              const Text(
                'Program Name',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
