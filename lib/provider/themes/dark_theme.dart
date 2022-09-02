import 'package:flutter/material.dart';

import '../theme.dart';

darkThemeData() => ThemeData(
      brightness: Brightness.dark,
      primaryColorDark: CustomeTheme.c2,
      primaryColorLight: Colors.white,
      colorScheme: const ColorScheme.dark().copyWith(
        secondary: CustomeTheme.c2.withBlue(200).withGreen(200),
        primaryContainer: CustomeTheme.c1.withAlpha(100),
        onPrimaryContainer: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
          shadowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomeTheme.c1.withAlpha(200);
              }
              return CustomeTheme.c1; // Use the component's default.
            },
          ),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return 10;
              }
              return 30; // Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomeTheme.c1.withAlpha(200);
              }
              return CustomeTheme.c1; // Use the component's default.
            },
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomeTheme.c1.withAlpha(100);
              }
              return CustomeTheme.c1;
            },
          ),
        ),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedIconColor: CustomeTheme.c1,
        collapsedTextColor: CustomeTheme.c1,
        iconColor: CustomeTheme.c1,
        textColor: CustomeTheme.c1,
      ),
      primaryColor: CustomeTheme.c1,
      backgroundColor: CustomeTheme.c1,
      tabBarTheme: const TabBarTheme(
        labelPadding: EdgeInsets.all(10),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        unselectedLabelColor: CustomeTheme.c1,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: CustomeTheme.c1,
        ),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: ThemeData.dark().appBarTheme.backgroundColor,
        actionsIconTheme: const IconThemeData(color: CustomeTheme.c1),
        iconTheme: const IconThemeData(color: CustomeTheme.c1),
      ),
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: Colors.white,
        selectedTileColor: CustomeTheme.c1.withAlpha(100),
      ),
    );
