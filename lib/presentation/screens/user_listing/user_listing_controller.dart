import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:folldy_admin/utils/snackbar_utils.dart';
import 'package:folldy_utils/domain/usecase/create_new_user.dart';
import 'package:folldy_utils/domain/usecase/list_all_users.dart';

import 'components/add_user_dialog.dart';

class UserListingController extends ChangeNotifier {
  ListAllUsers listAllUsers = ListAllUsers(Get.find());
  CreateNewUser createNewUser = CreateNewUser(Get.find());

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AppError? appError;
  bool isLoading = true;
  makeLoading() {
    isLoading = true;
    notifyListeners();
  }

  makeNotLoading() {
    isLoading = false;
    notifyListeners();
  }

  retry() async {
    appError = null;
    makeLoading();
    await Future.delayed(const Duration(seconds: 2));
    makeNotLoading();
  }

  List users = [];

  getData() async {
    final response = await listAllUsers(UserListingParam());
    response.fold((l) => appError = l, (r) {
      if (r["status"] == 1) {
        users = r["users"];
      } else {
        showErrorMessage(r["message"]);
      }
    });
    makeNotLoading();
  }

  void showAddUserDialog() {
    Get.dialog(const AddUserDialog());
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'create_user_form_key');
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

  void createUser() async {
    if (!validate()) return;
    makeButtonLoading();
    final response = await createNewUser(CreateUserParams(
      username: usernameController.text,
      password: passwordController.text,
    ));
    response.fold((l) => l.handleError(), (r) {
      if (r["status"] == 1) {
        getData();
        Get.back();
      } else {
        showErrorMessage(r["message"]);
      }
    });
    makeButtonNotLoading();
  }
}
