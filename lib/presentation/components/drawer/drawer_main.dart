// not used
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Pages/Authentication/authenticate.dart';
import '../../blocs/authentication/auth_bloc.dart';
import 'drawer_head.dart';

class TheDrawer extends StatelessWidget {
  const TheDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            tileColor: Colors.redAccent[300],
            title: const Text(
              'jobs',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onTap: () async {
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Authenticate()));
            },
          ),
          ListTile(
            tileColor: Colors.red[700],
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
              BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
              // Navigator.of(context).popUntil((route) => route is AuthBloc);
              // await Navigator.of(context).push(
              //     MaterialPageRoute(builder: (_) => const Authenticate()));
            },
          ),
        ],
      ),
    );
  }
}
