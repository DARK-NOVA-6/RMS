import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'tabs/tabs.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  List<Text> texts = const [
    Text('Personal Information', style: TextStyle(fontSize: 20)),
    Text(
      'Educational Qualifications',
      style: TextStyle(fontSize: 20),
    ),
    Text('Past Experience', style: TextStyle(fontSize: 20)),
    Text('Skills', style: TextStyle(fontSize: 20)),
    Text('Languages', style: TextStyle(fontSize: 20)),
  ];
  List<Widget> actions = [
    Padding(
      padding: const EdgeInsets.only(right: 10),
      child: IconButton(
        icon: const Icon(
          Icons.edit,
          size: 30,
        ),
        onPressed: () {},
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: CustomeAppBar(label: 'Profile', actions: actions),
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
    );
  }
}
