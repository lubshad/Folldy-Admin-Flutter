import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';

import 'package:folldy_admin/domain/usecase/add_subject.dart';
import 'package:folldy_admin/domain/usecase/get_all_courses.dart';
import 'package:folldy_admin/domain/usecase/get_all_subjects.dart';
import 'package:get/get.dart';

import '../../../data/models/subject_list_response.dart';

class SubjectListingController extends ChangeNotifier {
  SubjectListingController() {
    getData();
  }

  GetAllSubjects getAllSubjects = GetAllSubjects(Get.find());
  GetAllCourses getAllCourses = GetAllCourses(Get.find());
  AddNewSubject addNewSubject = AddNewSubject(Get.find());

  TextEditingController subjectNameController = TextEditingController();
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

  getData() {
    getSubjects();
    getCourses();
  }

  getSubjects() async {
    final response = await getAllSubjects(NoParams());
    response.fold((l) => l.handleError(), (r) => subjects = r);
    notifyListeners();
  }

  getCourses() async {
    final response = await getAllCourses(NoParams());
    response.fold((l) => l.handleError(), (r) => cources = r);
    notifyListeners();
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
                    controller: subjectNameController,
                    decoration: const InputDecoration(
                      labelText: "Subject Name",
                    ),
                    onFieldSubmitted: (val) => addSubject(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(onPressed: addSubject, child: const Text("Add")),
              ]);
        });
  }

  void addSubject() async {
    await addNewSubject(Subject(
        course: selectedCourse!.id, name: subjectNameController.text, id: 1));
    subjectNameController.clear();
    getData();
  }

  deleteSubject(Subject e) async {
    await deleteSubject(e);
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
