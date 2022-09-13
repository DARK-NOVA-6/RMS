import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/update_action_bar_actions_notification.dart';
import 'phone.dart';

class PhoneList extends StatelessWidget {
  const PhoneList({
    Key? key,
    required this.phones,
    required this.add,
    required this.remove,
  }) : super(key: key);

  final List<TextEditingController> phones;
  final Function() add;
  final Function(int) remove;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListTile(
          title: Text(
            'Phone',
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          trailing: (Provider.of<UpdateActionBarActions>(context).edit)
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: add,
                  ),
                )
              : null,
        ),
      ),
      children: [
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 10),
          itemCount: phones.length,
          itemBuilder: (context, index) {
            return PhoneTextField(
              enabled: Provider.of<UpdateActionBarActions>(context).edit,
              phone: phones[index],
              removePhone: () => remove(index),
            );
          },
        ),
      ],
    );
  }
}
