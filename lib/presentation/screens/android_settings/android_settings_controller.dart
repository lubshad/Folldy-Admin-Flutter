import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:folldy_utils/domain/usecase/fetch_android_settings.dart';
import 'package:folldy_utils/domain/usecase/update_android_settings.dart';

import '../../../utils/snackbar_utils.dart';

class AndroidSettingsController extends ChangeNotifier {
  UpdateAndroidSettings updateAndroidSettings =
      UpdateAndroidSettings(Get.find());

  FetchAndroidSettings fetchAndroidSettings = FetchAndroidSettings(Get.find());

  TextEditingController minimumVersionTeacherController =
      TextEditingController();
  TextEditingController currentVersionTeacherController =
      TextEditingController();

  TextEditingController updateMessageTeacherController =
      TextEditingController();

  TextEditingController appUrlTeacherController = TextEditingController();

  final formKey = GlobalKey<FormState>(debugLabel: 'android_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

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
  // retry() async {
  //   appError = null;
  //   makeLoading();
  //   await Future.delayed(const Duration(seconds: 2));
  //   makeNotLoading();
  // }

  getData() async {
    final response = await fetchAndroidSettings(NoParams());
    response.fold((l) => l.handleError(), (r) => handleResponse(r));
  }

  void update() async {
    if (!validate()) return;
    final response = await updateAndroidSettings(UpdateAndroidSettingsParams(
        appUrlTeacher: appUrlTeacherController.text,
        updateMessageTeacher: updateMessageTeacherController.text,
        currentVersionTeacher:
            int.tryParse(currentVersionTeacherController.text) ?? 0,
        minimumVersionTeacher:
            int.tryParse(minimumVersionTeacherController.text) ?? 0));
    response.fold((l) => l.handleError(), (r) => getData());
  }

  handleResponse(r) {
    if (r["status"] == 0) {
      showErrorMessage(r["message"]);
    } else {
      minimumVersionTeacherController.text =
          r["data"]["minimumVersionTeacher"].toString();
      currentVersionTeacherController.text =
          r["data"]["currentVersionTeacher"].toString();
      appUrlTeacherController.text = r["data"]["appUrlTeacher"];
      updateMessageTeacherController.text = r["data"]["updateMessageTeacher"];
    }
  }
}
