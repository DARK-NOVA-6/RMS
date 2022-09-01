import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/presentation/components/components.dart';
import 'package:untitled/presentation/controllers/personal_controllers.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import '../../../components/rounded_drop_down_button.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late List<TextEditingController> phones;
  late List<String> genders;
  late String gender;
  PersonalControllers personalControllers = PersonalControllers();

  addPhone() {
    phones.insert(phones.length, TextEditingController());
  }

  removePhone(index) {
    phones.removeAt(index);
  }

  changeValue(value) {
    gender = value;
  }

  @override
  void initState() {
    super.initState();
    phones = personalControllers.phones;
    genders = const ['Male', 'Female'];
    gender = 'Male';
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: mq.size.height,
        ),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
          ),
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              fNameTextField(context),
              mNameTextField(context),
              lNameTextField(context),
              emailTextField(context),
              ExpansionTile(
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
                    trailing:
                        (Provider.of<UpdateActionBarActions>(context).edit)
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
                                  onPressed: () => setState(
                                    () => addPhone(),
                                  ),
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
                        enabled:
                            Provider.of<UpdateActionBarActions>(context).edit,
                        phone: phones[index],
                        removePhone: () => setState(
                          () => removePhone(index),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Container(
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
                  valueChanged: (value) => setState(
                    () => changeValue(value),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container emailTextField(BuildContext context) {
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

  Container lNameTextField(BuildContext context) {
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

  Container mNameTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: RoundedTextField(
        enabled: Provider.of<UpdateActionBarActions>(context).edit,
        controller: personalControllers.mName,
        color: Theme.of(context).primaryColor,
        icon: Icons.icecream_outlined,
        label: 'Middle Name',
        w: 0.6,
      ),
    );
  }

  Container fNameTextField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: RoundedTextField(
        enabled: Provider.of<UpdateActionBarActions>(context).edit,
        controller: personalControllers.fName,
        color: Theme.of(context).primaryColor,
        icon: Icons.icecream_outlined,
        label: 'First Name',
        w: 0.6,
      ),
    );
  }
}

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
