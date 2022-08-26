import 'package:flutter/material.dart';
export 'applied/applied.dart';
export 'recomended/recomended.dart';
export 'unavailable/unavailable.dart';
export 'profile/profile.dart';
export 'jobs/jobs.dart';
abstract class Pages extends StatefulWidget {
  final String label = '';

  const Pages({Key? key}) : super(key: key);
}