
// ignore: must_be_immutable
import 'package:flutter/material.dart';

import 'bullet_point.dart';

class Tile extends StatelessWidget {
  Tile({
    Key? key,
    required this.text1,
    required this.text2,
    required this.indent,
    this.isSatisfied = true,
  }) : super(key: key);

  String text1;
  String text2;
  final bool indent, isSatisfied;

  @override
  Widget build(BuildContext context) {
    bool bullet = false;
    bool isLeft = false;
    if (text1 == '#') {
      text1 = '';
      bullet = true;
      isLeft = true;
    }
    if (text1 == '.') {
      isLeft = true;
    }
    TextStyle textStyle = TextStyle(
      fontWeight: indent ? null : FontWeight.bold,
      fontSize: indent ? 22 : 24,
      color: Theme.of(context).primaryColor,
    );
    TextStyle textStyle2 = TextStyle(
      color: (isSatisfied ? null : Colors.red),
      fontSize: indent || (text1 == '.') ? 22 : 24,
      fontWeight: FontWeight.bold,
    );
    if (text1 == '.') {
      text1 = '';
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: (indent)
            ? 40
            : (text2 != '' && text1 != '')
            ? 20
            : 8,
        vertical: (text1 == '' && text2 == '')
            ? 0
            : (text2 != '' && text1 != '')
            ? 10
            : 0,
      ),
      child: (text1 == '' && text2 == '')
          ? Divider(
        color: Theme.of(context).primaryColor,
        thickness: 1,
        indent: 25,
        endIndent: 25,
      )
          : (text2 != '' && text1 != '')
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1, style: textStyle),
          Text(text2, style: textStyle2),
        ],
      )
          : ListTile(
        leading: (bullet) ? const MyBullet() : null,
        title: Text(
          textAlign: (text2 == '')
              ? TextAlign.left
              : (isLeft)
              ? TextAlign.left
              : TextAlign.center,
          (text1 == '') ? text2 : text1,
          style: (text1 == '') ? textStyle2 : textStyle,
        ),
      ),
    );
  }
}
