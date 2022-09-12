import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  const Rating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: Icon(
            Icons.star,
            color: Colors.yellow,
            shadows: [
              Shadow(
                offset: const Offset(0, 0),
                color: Theme.of(context).primaryColor,
                blurRadius: 30,
              ),
            ],
            size: 35,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          rating.toString(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
            shadows: [
              Shadow(
                offset: const Offset(0, 0),
                color: Theme.of(context).primaryColor,
                blurRadius: 30,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
