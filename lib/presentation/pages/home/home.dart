import 'package:flutter/material.dart';

import '../../components/drawer/drawer.dart';
import '../../components/nav_bar.dart';
import '../nav_bar_pages/jobs/jobs.dart';
import '../nav_bar_pages/main_home/main_home.dart';
import '../nav_bar_pages/profile/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  final String title = 'Home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  int index = 0;
  List<Widget> icons = const [
    Icon(Icons.home),
    Icon(Icons.work_outline_rounded),
    Icon(Icons.person)
  ];
  List pages = const [
    MainHome(),
    Jobs(),
    Profile(),
  ];

  void changeIndex(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        index: index,
        changeIndex: changeIndex,
        icons: icons,
      ),
      drawer: const TheDrawer(),
      appBar: AppBar(
        title: Text(pages[index].label),
        centerTitle: true,
      ),
      body: pages[index],
    );
  }
}
