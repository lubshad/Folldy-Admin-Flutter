import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';

import 'package:folldy_admin/domain/usecase/add_new_course.dart';
import 'package:folldy_admin/domain/usecase/delete_course.dart';
import 'package:folldy_admin/domain/usecase/get_all_courses.dart';
import 'package:folldy_admin/domain/usecase/get_all_institutions.dart';
import 'package:folldy_admin/domain/usecase/get_all_universities.dart';

import '../../../data/models/course_list_response.dart';
import '../../../data/models/university_list_response.dart';

class CourseListingController extends ChangeNotifier {
  CourseListingController() {
    getUniversities();
    getInstitutes();
    getData();
  }

  GetAllUniversitys getAllUniversitys = GetAllUniversitys(Get.find());
  GetAllCourses getAllCourses = GetAllCourses(Get.find());
  GetAllInstitutions getAllInstitutions = GetAllInstitutions(Get.find());
  AddNewCourse addNewCourse = AddNewCourse(Get.find());
  DeleteCourse deleteCourse = DeleteCourse(Get.find());

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
          .where((element) => element.university == selectedUniversity!.id)
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

  getData() {
    getCourses();
    getUniversities();
    getInstitutes();
  }

  getCourses() async {
    final response = await getAllCourses(NoParams());
    response.fold((l) => l.handleError(), (r) => courses = r);
    notifyListeners();
  }

  getUniversities() async {
    final response = await getAllUniversitys(NoParams());
    response.fold((l) => l.handleError(), (r) => universities = r);
    notifyListeners();
  }

  getInstitutes() async {
    final response = await getAllInstitutions(NoParams());
    response.fold((l) => l.handleError(), (r) => institutes = r);
    notifyListeners();
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
                    onFieldSubmitted: (val) => addCourse(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(onPressed: addCourse, child: const Text("Add")),
              ]);
        });
  }

  void addCourse() async {
    await addNewCourse(Course(
        university: selectedUniversity!.id!,
        name: courseNameController.text,
        id: 1));
    courseNameController.clear();
    getData();
  }

  deleteSelectedCourse(Course e) async {
    await deleteCourse(e);
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
