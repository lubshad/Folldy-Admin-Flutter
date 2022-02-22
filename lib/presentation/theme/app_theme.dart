import 'package:flutter/material.dart';

const defaultPadding = 20.0;
const defaultSpacer = SizedBox(height: defaultPadding);
const defaultSpacerHorizontal = SizedBox(width: defaultPadding);

class AppTheme {
  static ThemeData get lightThemeData => ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      );
}
