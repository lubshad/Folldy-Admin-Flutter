import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/home_screen/home_screen.dart';

class AppRoute {
  static const String initial = '/';

  static Map<String, WidgetBuilder> get routes => {
        initial: (context) => const Home(),
      };
}
