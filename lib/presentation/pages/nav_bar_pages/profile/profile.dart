import 'package:flutter/material.dart';

import '../../../components/components.dart';
import '../pages.dart';

class Profile extends StatefulWidget implements Pages {
  const Profile({Key? key}) : super(key: key);

  @override
  String get label => 'Profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: const CustomeAppBar(label: 'Profile'),
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
            tabs: const [
              Text(
                'Personal Information',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Educational Qualifications',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Past Experience',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Skills',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Languages',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Container(
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
              ),
              Container(
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
              ),
              Container(
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
              ),
              Container(
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
              ),
              Container(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
