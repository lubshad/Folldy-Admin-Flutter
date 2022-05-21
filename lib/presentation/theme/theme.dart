import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const defaultAnimationDuration = Duration(milliseconds: 500);
const double slideAspectRatio = 0.55;

const double defaultPadding = 16;
const double defaultPaddingSmall = 8;
const double defaultPaddingLarge = 32;
const double defaultPaddingTiny = 4;
const defaultSpacerLarge = SizedBox(height: defaultPaddingLarge);
const defaultSpacer = SizedBox(height: defaultPadding);
const defaultSpacerHorizontal = SizedBox(width: defaultPadding);
const defaultSpacerSmall = SizedBox(height: defaultPaddingSmall);
const defaultSpacerTiny = SizedBox(height: defaultPaddingTiny);
const defaultSpacerHorizontalSmall = SizedBox(width: defaultPaddingSmall);
const defaultSpacerHorizontalTiny = SizedBox(width: defaultPaddingTiny);

const Color offWhite = Color(0xFFF2F2F2);
const Color porcelain = Color(0xFFF6F8F9);
const Color porcelainDark = Color(0xFFEAEDEE);
const Color waikawaGray = Color(0xFF657BAD);

final List<Color> randomColors = [
  const Color(0xFF855fa8),
  const Color(0xFFa99361),
  const Color(0xFF6076a8),
  const Color(0xFF006962),
];

const defaultShadow = [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(1.1, 1.1),
    blurRadius: 5,
  ),
];

class AppTheme {
  static setSystemOverlay() {
    if (kIsWeb) return;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  static ThemeData get theme => ThemeData.light().copyWith(
      // pageTransitionsTheme: PageTransitionsTheme(
      //   builders: {
      //     TargetPlatform.windows: NoTransitionBuilder(),
      //   },
      // ),
      platform: TargetPlatform.windows,
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.black,
      ),
      listTileTheme: const ListTileThemeData(dense: true),
      drawerTheme: const DrawerThemeData(elevation: 0),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        titleTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ));
}

extension TextThemeExtension on TextTheme {
  TextStyle get headline4Bold =>
      headline4!.copyWith(fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle get headline5Bold =>
      headline5!.copyWith(fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle get headline6Bold =>
      headline6!.copyWith(fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle get bodyText1Bold =>
      bodyText1!.copyWith(fontWeight: FontWeight.bold);
}
