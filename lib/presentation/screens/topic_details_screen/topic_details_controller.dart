import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:folldy_admin/domain/usecase/upload_topic_images.dart';
import 'package:folldy_admin/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../domain/entities/app_error.dart';
import 'package:http_parser/http_parser.dart';

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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, withReadStream: true, type: FileType.image);

    if (result != null) {
      List<http.MultipartFile> images = result.files
          .map((file) => http.MultipartFile(
              "slide", file.readStream!, file.size,
              filename: file.name, contentType: MediaType("image", "jpeg")))
          .toList();

      final response = await uploadTopicImages(
          UploadImageParams({"topic": "3"}, images, ApiConstants.uploadImage));
      response.fold((l) => l.handleError(), (r) => consolelog(r));
    }
  }
}
