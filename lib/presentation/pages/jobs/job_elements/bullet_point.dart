import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/theme_notifier.dart';

class MyBullet extends StatelessWidget {
  const MyBullet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        color: Provider.of<ThemeNotifier>(context).darkTheme
            ? Colors.white
            : Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
