import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/teacher_list_response.dart';
import 'package:folldy_admin/data/models/topic_details_response.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/usecase/add_new_presentation.dart';
import 'package:folldy_admin/domain/usecase/get_all_teachers.dart';
import 'package:folldy_admin/domain/usecase/get_topic_details.dart';
import 'package:folldy_admin/domain/usecase/upload_presentation_audio.dart';
import 'package:folldy_admin/domain/usecase/upload_topic_images.dart';
import 'package:folldy_admin/utils/utils.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import '../../../data/core/api_constants.dart';
import '../../../domain/entities/app_error.dart';
import 'package:http_parser/http_parser.dart';

class TopicDetailsController extends ChangeNotifier {
  Teacher? selectedTeacher;
  Presentation? selectedPresentation;

  TopicDetailsController() {
    topic = Get.arguments as Topic;
    getData();
    getTeachers();
  }
  List<Teacher> teachers = [];

  GetTopicDetails getTopicDetails = GetTopicDetails(Get.find());

  UploadTopicImages uploadTopicImages = UploadTopicImages(Get.find());

  UploadPresentationAudio uploadPresentationAudio =
      UploadPresentationAudio(Get.find());

  AddNewPresentation addNewPresentation = AddNewPresentation(Get.find());

  GetAllTeachers getAllTeachers = GetAllTeachers(Get.find());

  List<PlatformFile> pickedImages = [];

  AppError? appError;
  bool isLoading = true;

  List<Presentation> get presentations => topicDetailsResponse == null
      ? []
      : topicDetailsResponse!.data.presentations;

  List<DropdownMenuItem<Teacher>> get teacherItems => teachers
      .map((e) => DropdownMenuItem<Teacher>(value: e, child: Text(e.name)))
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

  Topic? topic;

  TopicDetailsResponse? topicDetailsResponse;

  getData() async {
    final response = await getTopicDetails(topic!);
    response.fold((l) => consolelog("error"), (r) => topicDetailsResponse = r);
    notifyListeners();
  }

  Stream<List<int>> getFileStream(Uint8List bytes) =>
      Stream.fromIterable([bytes]);

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    // consolelog(result!.files.first.name);
    if (result != null) {
      List<http.MultipartFile> images = result.files
          .map((file) => http.MultipartFile(
              "slide", getFileStream(file.bytes!), file.size,
              filename: file.name, contentType: MediaType("image", "jpeg")))
          .toList();

      final response = await uploadTopicImages(UploadFileParams(
          {"presentation": selectedPresentation!.id},
          images,
          ApiConstants.uploadSlides));
      response.fold((l) => l.handleError(), (r) => getData());
    }
  }

  pickAudio() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.audio);
    // consolelog(result!.files.first.name);
    if (result != null) {
      List<http.MultipartFile> audioFiles = result.files
          .map((file) => http.MultipartFile(
              "audio", getFileStream(file.bytes!), file.size,
              filename: file.name))
          .toList();

      final response = await uploadPresentationAudio(UploadFileParams(
          {"presentation": selectedPresentation!.id},
          audioFiles,
          ApiConstants.uploadAudios));
      response.fold((l) => l.handleError(), (r) => getData());
    }
  }

  void showAddPresentationDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New institution"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Teacher>(
                      decoration: const InputDecoration(
                        hintText: "Select Teacher",
                      ),
                      items: teacherItems,
                      onChanged: changeSelectedTeacher),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: addPresentation, child: const Text("Add")),
              ]);
        });
  }

  void getTeachers() async {
    final response = await getAllTeachers(NoParams());
    response.fold((l) => l.handleError(), (r) => teachers = r);
  }

  void addPresentation() async {
    final response = await addNewPresentation(
        Presentation(id: 1, teacher: selectedTeacher!, topic: topic!));
    response.fold((l) => l.handleError(), (r) => getData());
  }

  void changeSelectedTeacher(Teacher? value) {
    selectedTeacher = value;
  }

  changePresentation(Presentation e) {
    selectedPresentation = e;
    notifyListeners();
  }
}
