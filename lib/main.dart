import 'package:flutter/material.dart';
import 'package:folldy_admin/di/di.dart';
import 'package:folldy_admin/presentation/app_route.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:get/get.dart';

import 'presentation/screens/home_screen/home_screen.dart';

void main() {
  setupApp();
  runApp(const MyApp());
}

void setupApp() {
  DependencyInjection.inject();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Folldy Admin',
      theme: AppTheme.theme,
      home: const Home(),
      routes: AppRoute.routes,
      defaultTransition: Transition.downToUp,
    );
  }
}
