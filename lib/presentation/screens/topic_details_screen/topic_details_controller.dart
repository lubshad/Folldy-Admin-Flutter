import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:folldy_admin/domain/usecase/upload_topic_images.dart';
import 'package:folldy_admin/utils/utils.dart';
import 'package:get/get.dart';

import '../../../domain/entities/app_error.dart';

class TopicDetailsController extends ChangeNotifier {
  TopicDetailsController() {
    getData();
  }

  UploadTopicImages uploadTopicImages = UploadTopicImages(Get.find());

  List<PlatformFile> pickedImages = [];

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
    makeLoading();
    await Future.delayed(const Duration(seconds: 2));
    makeNotLoading();
  }

  getData() async {
    await Future.delayed(const Duration(seconds: 2));
    makeNotLoading();
  }

  pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      pickedImages = result.files.map((path) => path).toList();
      Map<String, PlatformFile> images = {};
      for (PlatformFile element in pickedImages) {
        images.addAll({"file_field": element});
      }
      final response = await uploadTopicImages(UploadImageParams(
          {"data": "data"}, images, ApiConstants.uploadImage));
      consolelog(response);
    }
  }
}
