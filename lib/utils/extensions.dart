
import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}'
      '${alpha.toRadixString(16).padLeft(2, '0')}';
}

extension TextDecorationExtension on String {
  TextDecoration get textDecoration {
    switch (this) {
      case 'TextDecoration.underline':
        return TextDecoration.underline;
      case 'TextDecoration.lineThrough':
        return TextDecoration.lineThrough;
      case 'TextDecorationoverline':
        return TextDecoration.overline;
      default:
        return TextDecoration.none;
    }
  }
}

void popDialog() {
  if (Get.isDialogOpen == true) Get.back();
}


extension AppErrorTypeExtension on AppErrorType {
  String get message {
    switch (this) {
      case AppErrorType.api:
        return 'Api Error';
      case AppErrorType.network:
        return 'Network Error';
      case AppErrorType.database:
        return 'Database Error';
      case AppErrorType.unauthorised:
        return 'Unauthorised Error';
      case AppErrorType.sessionDenied:
        return 'Session Denied Error';
    }
  }

  String get svgImage {
    switch (this) {
      case AppErrorType.api:
        return 'assets/svgs/api_error.svg';
      case AppErrorType.network:
        return 'assets/svgs/network_error.svg';
      case AppErrorType.database:
        return 'assets/svgs/database_error.svg';
      case AppErrorType.unauthorised:
        return 'assets/svgs/unauthorised_error.svg';
      case AppErrorType.sessionDenied:
        return 'assets/svgs/session_denied_error.svg';
    }
  }

 
}


extension AppErrorExtension on AppError {
   handleError() {
    logger.info(appErrorType);
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(appErrorType.message),
      ),
    );
  }
}

