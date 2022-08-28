import 'package:flutter/material.dart';

class EducationalQualifications extends StatelessWidget {
  const EducationalQualifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
      ),
      child: const Center(
        child: Text('Personal Information'),
      ),
    );
  }
}
