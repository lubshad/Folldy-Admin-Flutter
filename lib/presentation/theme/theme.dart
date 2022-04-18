import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

const defaultAnimationDuration = Duration(milliseconds: 500);
const double slideAspectRatio = 0.55;

const double defaultPadding = 20.0;
const double defaultPaddingSmall = 10.0;
const double defaultPaddingLarge = 40.0;
const double defaultPaddingTiny = 5.0;
const defaultSpacerLarge = SizedBox(height: defaultPaddingLarge);
const defaultSpacer = SizedBox(height: defaultPadding);
const defaultSpacerHorizontal = SizedBox(width: defaultPadding);
const defaultSpacerSmall = SizedBox(height: defaultPadding * .5);
const defaultSpacerTiny = SizedBox(height: defaultPadding * .25);
const defaultSpacerHorizontalSmall = SizedBox(width: defaultPadding * .5);
const defaultSpacerHorizontalTiny = SizedBox(width: defaultPadding * .25);

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
          appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
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
