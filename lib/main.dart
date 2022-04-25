import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:folldy_admin/di/di.dart';
import 'package:folldy_admin/presentation/app_route.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:get/get.dart';

void main() {
  setupApp();
  runApp(const MyApp());
}

void setupApp() {
  setUrlStrategy(PathUrlStrategy());
  DependencyInjection.inject();
  setupLogger();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Folldy Admin',
      theme: AppTheme.theme,
      routes: AppRoute.routes,
    );
  }
}
