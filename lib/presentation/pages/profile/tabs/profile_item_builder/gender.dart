import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/update_action_bar_actions_notification.dart';
import '../../../../components/components.dart';

class GenderBuilder extends StatelessWidget {
  const GenderBuilder({
    Key? key,
    required this.genders,
    required this.gender,
    required this.chVal,
  }) : super(key: key);

  final List<String> genders;
  final String gender;
  final Function(int) chVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: RoundedDropdownButton(
        enabled: Provider.of<UpdateActionBarActions>(context).edit,
        color: Theme.of(context).primaryColor,
        label: 'Gender',
        icon: Icons.person_pin,
        list: genders,
        value: gender,
        valueChanged: chVal,
      ),
    );
  }
}