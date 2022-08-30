import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/update_action_bar_actions_notification.dart';

import '../../components/components.dart';
import 'tabs/tabs.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<Text> texts = [
    const Text('Personal Information', style: TextStyle(fontSize: 20)),
    const Text(
      'Educational Qualifications',
      style: TextStyle(fontSize: 20),
    ),
    const Text('Past Experience', style: TextStyle(fontSize: 20)),
    const Text('Skills', style: TextStyle(fontSize: 20)),
    const Text('Languages', style: TextStyle(fontSize: 20)),
  ];
  late List<Widget> actions1;
  late List<Widget> actions2;

  @override
  void initState() {
    super.initState();
    actions2 = [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            Icons.edit,
            size: 30,
          ),
          onPressed: () {
            Provider.of<UpdateActionBarActions>(context, listen: false)
                .changeEditMode(true);
          },
        ),
      ),
    ];
    actions1 = [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            Icons.published_with_changes_outlined,
            size: 30,
          ),
          onPressed: () {
            Provider.of<UpdateActionBarActions>(context, listen: false)
                .changeEditMode(false);
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Scaffold(
          appBar: CustomeAppBar(
            label: 'Profile',
            actions1: actions1,
            actions2: actions2,
          ),
          body: Scaffold(
            appBar: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              isScrollable: true,
              // padding: const EdgeInsets.only(top: 10),
              onTap: (value) {},
              tabs: texts,
            ),
            body: const TabBarView(
              children: [
                PersonalInformation(),
                EducationalQualifications(),
                PastExperiences(),
                Skills(),
                Languages(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
