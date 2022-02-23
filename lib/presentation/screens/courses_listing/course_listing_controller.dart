import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/remote_data_source.dart';
import 'package:get/get.dart';

import '../../../data/models/course_list_response.dart';
import '../../../data/models/university_list_response.dart';

class CourseListingController extends ChangeNotifier {
  CourseListingController() {
    getUniversities();
    // getInstitutes();
    getData();
  }

  TextEditingController courseNameController = TextEditingController();
  List<Course> courses = [];
  List<University> universities = [];
  List<Institution> institutes = [];

  University? selectedUniversity;
  Institution? selectedInstitution;
  bool? appError;
  bool isLoading = true;

  get universitiesItems => universities
      .map((e) => DropdownMenuItem<University>(value: e, child: Text(e.name)))
      .toList();

  get institutesItems => selectedUniversity == null
      ? null
      : institutes
          .where((element) =>
              element.university == selectedUniversity!.name.toString())
          .map((e) =>
              DropdownMenuItem<Institution>(value: e, child: Text(e.name)))
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
    courses = await RemoteDataSource.getAllCourses();
    notifyListeners();
  }

  getUniversities() async {
    universities = await RemoteDataSource.getAllUnivresity();
  }

  getInstitutes() async {
    institutes = await RemoteDataSource.getAllInstitutions();
  }

  showAddCourseDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New Course"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<University>(
                      decoration: const InputDecoration(
                        hintText: "Select University",
                      ),
                      items: universitiesItems,
                      onChanged: changeSelectedUniversity),
                  TextFormField(
                    controller: courseNameController,
                    decoration: const InputDecoration(
                      labelText: "Course Name",
                    ),
                    onFieldSubmitted: (val) => addNewCourse(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: addNewCourse, child: const Text("Add")),
              ]);
        });
  }

  void addNewCourse() async {
    await RemoteDataSource.addCourse(
        courseNameController.text, selectedUniversity!.id);
    courseNameController.clear();
    getData();
  }

  deleteCourse(Course e) async {
    await RemoteDataSource.deleteCourse(e.id);
    getData();
  }

  void changeSelectedUniversity(University? value) {
    selectedUniversity = value;
    notifyListeners();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }
}
