import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/usecase/upload_topic_images.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../data/models/chapter_list_response.dart';
import '../../../data/models/teacher_list_response.dart';
import '../../../domain/usecase/add_new_teacher.dart';
import '../../../domain/usecase/delete_teacher.dart';
import '../../../domain/usecase/get_all_teachers.dart';

class TeacherListingController extends ChangeNotifier {
  TeacherListingController() {
    getData();
  }
  PlatformFile? selectedImage;

  GetAllTeachers getAllTeachers = GetAllTeachers(Get.find());
  AddNewTeacher addNewTeacher = AddNewTeacher(Get.find());
  DeleteTeacher deleteTeacher = DeleteTeacher(Get.find());

  TextEditingController teacherNameController = TextEditingController();
  List<Teacher> teachers = [];
  List<Chapter> chapters = [];
  // List<Institution> institutes = [];

  Chapter? selectedChapter;
  Institution? selectedInstitution;
  bool? appError;
  bool isLoading = true;

  get chaptersItems => chapters
      .map((e) => DropdownMenuItem<Chapter>(value: e, child: Text(e.name)))
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

  getTeachers() async {
    final response = await getAllTeachers(NoParams());
    response.fold((l) => l.handleError(), (r) => teachers = r);
    notifyListeners();
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      selectedImage = result.files.first;
      showAddTeacherDialog();
      // List<http.MultipartFile> images = result.files
      //     .map((file) => http.MultipartFile(
      //         "profile", file.readStream!, file.size,
      //         filename: file.name, contentType: MediaType("image", "jpeg")))
      //     .toList();

      // final response = await uploadTopicImages(
      //     UploadFileParams({"teacher": "3"}, images, ApiConstants.uploadImage));
      // response.fold((l) => l.handleError(), (r) => getData());
    }
  }

  showAddTeacherDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New Teacher"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Builder(builder: (context) {
                    return Image.memory(
                      selectedImage!.bytes!,
                      height: 100,
                      width: 100,
                    );
                  }),
                  TextFormField(
                    controller: teacherNameController,
                    decoration: const InputDecoration(
                      labelText: "Teacher Name",
                    ),
                    onFieldSubmitted: (val) => addTeacher(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(onPressed: addTeacher, child: const Text("Add")),
              ]);
        });
  }

  Stream<List<int>> get imageStream =>
      Stream.fromIterable(selectedImage!.bytes!.map((e) => [e]));

  void addTeacher() async {
    http.MultipartFile image = http.MultipartFile(
        "profile", imageStream, selectedImage!.size,
        filename: selectedImage!.name, contentType: MediaType("image", "jpeg"));
    UploadFileParams uploadFileParams = UploadFileParams(
        {"name": teacherNameController.text},
        [image],
        ApiConstants.addNewTeacher);
    final response = await addNewTeacher(uploadFileParams);
    response.fold((l) => l.handleError(), (r) {
      teacherNameController.clear();
      getData();
    });
  }

  deleteSelectedTeacher(Teacher e) async {
    await deleteTeacher(e);
    getData();
  }

  void changeSelectedChapter(Chapter? value) {
    selectedChapter = value;
    notifyListeners();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }

  void getData() {
    getTeachers();
  }
}
