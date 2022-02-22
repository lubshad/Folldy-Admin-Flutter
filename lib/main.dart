import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/theme/app_theme.dart';
import 'package:get/get.dart';

import 'presentation/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Folldy Admin',
      theme: AppTheme.lightThemeData,
      home: const Home(),
    );
  }
}
