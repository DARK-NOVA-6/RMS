import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;

  const MenuItem({required this.title, required this.icon});
}

class MenuItems {
  static const MenuItem jobs = MenuItem(
    title: 'Jobs',
    icon: Icons.work_outline_rounded,
  );
  static const MenuItem profile = MenuItem(
    title: 'Profile',
    icon: Icons.person_outline_outlined,
  );
  static const MenuItem mailBox = MenuItem(
    title: 'MailBox',
    icon: Icons.mail_outline_rounded,
  );
  static const MenuItem reports = MenuItem(
    title: 'Reports',
    icon: Icons.report_rounded,
  );
  static const MenuItem aboutUs = MenuItem(
    title: 'About Us',
    icon: Icons.info_outline_rounded,
  );
  static const MenuItem rateUs = MenuItem(
    title: 'Rate Us',
    icon: Icons.star_rate_outlined,
  );
  static List<MenuItem> group1 = <MenuItem>[
    jobs,
    profile,
    mailBox,
  ];
  static List<MenuItem> group2 = <MenuItem>[
    reports,
    aboutUs,
    rateUs,
  ];
}