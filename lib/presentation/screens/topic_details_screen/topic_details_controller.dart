import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:folldy_admin/data/models/topic_details_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/domain/usecase/get_topic_details.dart';
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

  GetTopicDetails getTopicDetails = GetTopicDetails(Get.find());

  UploadTopicImages uploadTopicImages = UploadTopicImages(Get.find());

  List<PlatformFile> pickedImages = [];

  AppError? appError;
  bool isLoading = true;

  get images => topicDetailsResponse == null
      ? []
      : topicDetailsResponse!.data.slides
          .map((e) => "http://127.0.0.1:8000" + e.slide)
          .toList();

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

  Topic topic = Get.arguments;

  TopicDetailsResponse? topicDetailsResponse;

  getData() async {
    final response = await getTopicDetails(topic);
    response.fold((l) => consolelog("error"), (r) => topicDetailsResponse = r);
    notifyListeners();
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
          UploadFileParams({"topic": "3"}, images, ApiConstants.uploadImage));
      response.fold((l) => l.handleError(), (r) => getData());
    }
  }
}
