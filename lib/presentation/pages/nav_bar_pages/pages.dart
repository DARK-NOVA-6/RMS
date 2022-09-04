import 'package:flutter/material.dart';

export 'applied/applied.dart';
export 'recommended/recommended.dart';
export 'unavailable/unavailable.dart';

abstract class Pages extends StatefulWidget {
  final String label = '';

  const Pages({Key? key}) : super(key: key);
}
