import 'package:flutter/material.dart';
import '../theme.dart';

lightThemeData() => ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light().copyWith(
        secondary: CustomeTheme.c1.withGreen(50).withBlue(250).withRed(0),
      ),
      primaryColorDark: CustomeTheme.c1..withAlpha(220),
      primaryColorLight: CustomeTheme.c2,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 10),
          ),
          shadowColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomeTheme.c2.withAlpha(200);
              }
              return CustomeTheme.c2; // Use the component's default.
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
                return CustomeTheme.c2.withAlpha(200);
              }
              return CustomeTheme.c2; // Use the component's default.
            },
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return CustomeTheme.c2.withAlpha(100);
              }
              return CustomeTheme.c2;
            },
          ),
        ),
      ),
      expansionTileTheme: const ExpansionTileThemeData(
        collapsedIconColor: CustomeTheme.c2,
        collapsedTextColor: Colors.white,
        iconColor: CustomeTheme.c2,
        textColor: CustomeTheme.c2,
      ),
      primaryColor: CustomeTheme.c2,
      backgroundColor: CustomeTheme.c2,
      tabBarTheme: const TabBarTheme(
        labelPadding: EdgeInsets.all(10),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.white,
        unselectedLabelColor: CustomeTheme.c2,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: CustomeTheme.c2),
      ),
      appBarTheme: AppBarTheme(
        foregroundColor: CustomeTheme.c2,
        backgroundColor: ThemeData.dark().appBarTheme.backgroundColor,
        actionsIconTheme: const IconThemeData(color: CustomeTheme.c2),
        iconTheme: const IconThemeData(color: CustomeTheme.c2),
      ),
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
      listTileTheme: ListTileThemeData(
        selectedColor: Colors.white,
        selectedTileColor: CustomeTheme.c2.withAlpha(100),
      ),
    );
