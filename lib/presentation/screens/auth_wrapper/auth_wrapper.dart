import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/auth_wrapper/auth_controller.dart';
import 'package:folldy_admin/presentation/screens/home_screen/home_screen.dart';

import '../login_screen/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();

    return AnimatedBuilder(
        animation: authController,
        builder: (context, child) =>
            authController.user == null ? const LoginScreen() : const Home());
  }
}
