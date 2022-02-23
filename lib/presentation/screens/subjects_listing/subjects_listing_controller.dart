import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/remote_data_source.dart';
import 'package:get/get.dart';

import '../../../data/models/subject_list_response.dart';

class SubjectListingController extends ChangeNotifier {
  SubjectListingController() {
    getCourses();
    getData();
  }

  TextEditingController courseNameController = TextEditingController();
  List<Subject> subjects = [];
  List<Course> cources = [];
  // List<Institution> institutes = [];

  Course? selectedCourse;
  Institution? selectedInstitution;
  bool? appError;
  bool isLoading = true;

  get courcesItems => cources
      .map((e) => DropdownMenuItem<Course>(value: e, child: Text(e.name)))
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

  getData() async {
    subjects = await RemoteDataSource.getAllSubjects();
    notifyListeners();
  }

  getCourses() async {
    cources = await RemoteDataSource.getAllCourses();
  }

  showAddSubjectDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New Subject"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Course>(
                      decoration: const InputDecoration(
                        hintText: "Select Course",
                      ),
                      items: courcesItems,
                      onChanged: changeSelectedCourse),
                  TextFormField(
                    controller: courseNameController,
                    decoration: const InputDecoration(
                      labelText: "Subject Name",
                    ),
                    onFieldSubmitted: (val) => addNewSubject(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: addNewSubject, child: const Text("Add")),
              ]);
        });
  }

  void addNewSubject() async {
    await RemoteDataSource.addSubject(
        courseNameController.text, selectedCourse!.id);
    courseNameController.clear();
    getData();
  }

  deleteSubject(Subject e) async {
    await RemoteDataSource.deleteSubject(e.id);
    getData();
  }

  void changeSelectedCourse(Course? value) {
    selectedCourse = value;
    notifyListeners();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }
}
