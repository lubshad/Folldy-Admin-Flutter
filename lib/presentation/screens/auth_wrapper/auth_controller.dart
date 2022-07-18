import 'dart:convert';

import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:folldy_admin/utils/snackbar_utils.dart';
import 'package:folldy_utils/domain/usecase/admin_login.dart';
import 'package:folldy_utils/domain/usecase/admin_logout.dart';

final box = GetStorage();

class AuthController extends ChangeNotifier {
  AuthController() {
    String? savedUser = box.read("user");
    if (savedUser != null) {
      user = jsonDecode(savedUser);
      notifyListeners();
    }
    box.listenKey("user", (value) {
      if (value == null) {
        user = null;
        notifyListeners();
      } else {
        user = jsonDecode(value);
        notifyListeners();
      }
    });
  }
  Map<String, dynamic>? user;

  // User? user;
  // final firebaseAuthInstance = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>(debugLabel: 'login_form_key');
  AdminLogin adminLogin = AdminLogin(Get.find());
  AdminLogout adminLogout = AdminLogout(Get.find());
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  bool buttonLoading = false;
  makeButtonLoading() {
    buttonLoading = true;
    notifyListeners();
  }

  makeButtonNotLoading() {
    buttonLoading = false;
    notifyListeners();
  }

  logout() async {
    final response = await adminLogout(NoParams());
    response.fold((l) => l.handleError(), (r) {
      if (r["status"] == 1) {
        box.write("user", null);
      }
    });
  }

  bool obscureText = true;
  changePasswordVissibility() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void login() async {
    if (!validate()) return;
    makeButtonLoading();
    final response = await adminLogin(AdminLoginParams(
        username: usernameController.text, password: passwordController.text));
    response.fold((l) => l.handleError(), (r) {
      if (r["status"] == 1) {
        box.write("user", jsonEncode(r["user"]));
        usernameController.clear();
        passwordController.clear();
        obscureText = true;
      } else {
        showErrorMessage(r["message"]);
      }
    });
    makeButtonNotLoading();
  }
}
