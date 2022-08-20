import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../nav_bar_pages/pages.dart';

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
  List pages =  [
    const MainHome(),
    Jobs(),
    const Profile(),
  ];

  void changeIndex(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        index: index,
        changeIndex: changeIndex,
        icons: icons,
      ),
      drawer: const TheDrawer(),
      appBar: CustomeAppBar(label: pages[index].label),
      body: pages[index],
    );
  }
}


