import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.425,
      bottom: MediaQuery.of(context).size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
            color: Theme.of(context).primaryColor,
            strokeWidth: 8,
          ),
        ),
      ),
    );
  }
}