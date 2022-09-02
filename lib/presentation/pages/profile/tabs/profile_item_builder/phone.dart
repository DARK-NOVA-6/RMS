import 'package:flutter/material.dart';

import '../../../../components/components.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    Key? key,
    required this.phone,
    required this.removePhone,
    required this.enabled,
  }) : super(key: key);

  final TextEditingController phone;
  final Function removePhone;
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
            controller: phone,
            color: Theme.of(context).primaryColor,
            icon: Icons.phone,
          ),
          if (enabled) ...[
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => removePhone(),
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