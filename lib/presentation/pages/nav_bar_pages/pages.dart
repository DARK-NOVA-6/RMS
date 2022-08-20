import 'package:flutter/material.dart';
export 'jobs/jobs.dart';
export 'profile/profile.dart';
export 'main_home/main_home.dart';

abstract class Pages extends StatefulWidget {
  final String label = '';

  const Pages({Key? key}) : super(key: key);
}