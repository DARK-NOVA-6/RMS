import 'package:flutter/material.dart';

import '../../../../components/components.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.email,
    required this.removeEmail,
    required this.enabled,
  }) : super(key: key);

  final TextEditingController email;
  final Function removeEmail;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedTextField(
            enabled: enabled,
            controller: email,
            color: Theme.of(context).primaryColor,
            icon: Icons.phone,
          ),
          if (enabled) ...[
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => removeEmail(),
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  size: 32,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
