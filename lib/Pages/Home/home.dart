import 'package:flutter/material.dart';

import '../../Components/Drawer/Drawer.dart';
import '../../Components/NavBar.dart';
import '../NavBarPages/MainHome/MainHome.dart';
import '../NavBarPages/Jobs/Jobs.dart';
import '../NavBarPages/Profile/Profile.dart';

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
