import 'package:flutter/material.dart';

import '../../../../components/components.dart';
import '../../../../controllers/controllers.dart';

class EmailBuilder extends StatelessWidget {
  const EmailBuilder({
    Key? key,
    required this.personalControllers,
  }) : super(key: key);

  final PersonalControllers personalControllers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: RoundedTextField(
        enabled: false,
        controller: personalControllers.email,
        color: Theme.of(context).primaryColor,
        icon: Icons.email_outlined,
        label: 'Email',
        email: true,
        w: 0.6,
      ),
    );
  }
}