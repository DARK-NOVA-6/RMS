import 'package:flutter/material.dart';

import '../../Pages/Authentication/Authenticate.dart';
import 'DrawerHead.dart';

class TheDrawer extends StatelessWidget {
  const TheDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHead(),
          ListTile(
            leading: const Icon(
              Icons.work_outline_rounded,
              color: Colors.black,
            ),
            tileColor: Colors.blueGrey[300],
            title: const Text(
              'Jobs',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_)=>
                  const Authinticate()
                )
              );
            },
          ),
          ListTile(
            tileColor: Colors.blueGrey[700],
            contentPadding: const EdgeInsets.symmetric(horizontal: 100),
            title: const Text(
              'Log-out',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            trailing: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
            onTap: () async {
              Navigator.of(context).popUntil((route) => false);
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Authinticate()));
            },
          ),
        ],
      ),
    );
  }
}
