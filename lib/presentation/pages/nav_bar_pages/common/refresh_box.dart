import 'package:flutter/material.dart';

import '../../../../provider/theme.dart';

class RefreshBox extends StatelessWidget {
  const RefreshBox({
    Key? key,
    required this.text,
    this.subText = '',
    required this.onRefresh,
  }) : super(key: key);

  final Function() onRefresh;
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(bottom: 50, top: 10),
      color: CustomeTheme.c2.withAlpha(70),
      child: Center(
        child: ListTile(
          title: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
          trailing: const Icon(
            Icons.refresh,
            size: 40,
          ),
          onTap: onRefresh,
          subtitle: Text(
            (subText == '') ? 'Refresh' : subText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
