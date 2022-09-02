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
          child: const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 35,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          rating.toString(),
          style: const TextStyle(
            fontSize: 24,
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }
}

