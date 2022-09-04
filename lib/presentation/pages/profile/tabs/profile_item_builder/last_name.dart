import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/update_action_bar_actions_notification.dart';
import '../../../../components/components.dart';
import '../../../../controllers/controllers.dart';

class LastNameBuilder extends StatelessWidget {
  const LastNameBuilder({
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
        enabled: Provider.of<UpdateActionBarActions>(context).edit,
        controller: personalControllers.lName,
        color: Theme.of(context).primaryColor,
        icon: Icons.icecream_outlined,
        label: 'Last Name',
        w: 0.6,
      ),
    );
  }
}
