import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';

import 'package:folldy_admin/domain/usecase/add_new_course.dart';
import 'package:folldy_admin/domain/usecase/delete_course.dart';
import 'package:folldy_admin/domain/usecase/get_all_courses.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/course_list_response.dart';
import '../../../data/models/university_list_response.dart';

class CourseListingController extends ChangeNotifier {
  // GetAllUniversitys getAllUniversitys = GetAllUniversitys(Get.find());
  GetAllCourses getAllCourses = GetAllCourses(Get.find());
  // GetAllInstitutions getAllInstitutions = GetAllInstitutions(Get.find());
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
  }

  getCourses() async {
    final response = await getAllCourses(NoParams());
    response.fold((l) => l.handleError(), (r) => courses = r);
    makeNotLoading();
  }

  // getUniversities({int? universityId}) async {
  //   // final response = await getAllUniversitys(NoParams());
  //   response.fold((l) => l.handleError(), (r) => universities = r);
  //   selectedUniversity =
  //       universities.firstWhereOrNull((element) => element.id == universityId);
  //   notifyListeners();
  // }

  // getInstitutes() async {
  //   final response = await getAllInstitutions(NoParams());
  //   response.fold((l) => l.handleError(), (r) => institutes = r);
  //   notifyListeners();
  // }

  showAddCourseDialog() {
    courseNameController.clear();
    // getUniversities();
    Get.dialog(AlertDialog(
        title: const Text("Add New Course"),
        content: Form(
          key: formKey,
          child: AnimatedBuilder(
              animation: this,
              builder: (context, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // DropdownButtonFormField<University>(
                    //     decoration: const InputDecoration(
                    //       hintText: "Select University",
                    //     ),
                    //     items: universitiesItems,
                    //     validator: (value) =>
                    //         value == null ? "Select University" : null,
                    //     onChanged: changeSelectedUniversity),
                    TextFormField(
                      controller: courseNameController,
                      decoration: const InputDecoration(
                        labelText: "Course Name",
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter Course Name" : null,
                      onFieldSubmitted: (val) => addCourse(),
                    ),
                  ],
                );
              }),
        ),
        actions: [
          ElevatedButton(onPressed: addCourse, child: const Text("Add")),
        ]));
  }

  void addCourse({Course? course}) async {
    if (!formKey.currentState!.validate()) return;
    await addNewCourse(Course(
      id: course?.id,
      // university: selectedUniversity!.id!,
      name: courseNameController.text,
    ));
    getData();
    popDialog();
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

  final formKey = GlobalKey<FormState>(debugLabel: 'course_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  showEditCourseDialog(Course e) {
    courseNameController.text = e.name;
    // getUniversities(universityId: e.university);

    Get.dialog(AlertDialog(
        title: const Text("Edit Course"),
        content: Form(
          key: formKey,
          child: AnimatedBuilder(
              animation: this,
              builder: (context, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // DropdownButtonFormField<University>(
                    //     decoration: const InputDecoration(
                    //       hintText: "Select University",
                    //     ),
                    //     value: selectedUniversity,
                    //     items: universitiesItems,
                    //     validator: (value) =>
                    //         value == null ? "Select University" : null,
                    //     onChanged: changeSelectedUniversity),
                    TextFormField(
                      controller: courseNameController,
                      decoration: const InputDecoration(
                        labelText: "Course Name",
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter Course Name" : null,
                    ),
                  ],
                );
              }),
        ),
        actions: [
          ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => addCourse(course: e), child: const Text("Save")),
        ]));
  }

  showDeleteCourseConfirmation(Course e) {
    Get.dialog(AlertDialog(
        title: const Text("Delete Course"),
        content: Text("Are you sure you want to delete course ${e.name}?"),
        actions: [
          ElevatedButton(
              onPressed: () {
                popDialog();
              },
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                deleteSelectedCourse(e);
                popDialog();
              },
              child: const Text("Delete")),
        ]));
  }
}
