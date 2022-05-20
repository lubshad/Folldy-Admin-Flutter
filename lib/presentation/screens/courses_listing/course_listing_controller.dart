import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';

import 'package:folldy_admin/domain/usecase/add_new_course.dart';
import 'package:folldy_admin/domain/usecase/delete_course.dart';
import 'package:folldy_admin/domain/usecase/get_all_courses.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/course_list_response.dart';
import '../../../data/models/university_list_response.dart';

class CourseListingController extends ChangeNotifier {
  University? university;
  GetAllCourses getAllCourses = GetAllCourses(Get.find());
  AddNewCourse addNewCourse = AddNewCourse(Get.find());
  DeleteCourse deleteCourse = DeleteCourse(Get.find());

  TextEditingController courseNameController = TextEditingController();
  TextEditingController searchCourseController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  List<Course> courses = [];
  List<University> universities = [];
  List<Institution> institutes = [];

  Course? selectedCourse;

  Institution? selectedInstitution;
  bool? appError;
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

  getCourses() async {
    final response = await getAllCourses(CourseListingParams(
        universityId: university?.id, searchKey: searchCourseController.text));
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
    semesterController.clear();
    // getUniversities();
    Get.dialog(AlertDialog(
        title: const Text("Add New Course"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: courseNameController,
                decoration: const InputDecoration(
                  labelText: "Course Name",
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter Course Name" : null,
                onFieldSubmitted: (val) => addCourse(),
              ),
              TextFormField(
                  controller: semesterController,
                  decoration: const InputDecoration(
                    labelText: "Semesters",
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Semesters is required";
                    }
                    final semester = int.tryParse(value);
                    if (semester == null) {
                      return "Semesters must be a number";
                    }
                    if (semester < 1 || semester > 8) {
                      return "Semesters must be between 1 and 8";
                    }
                    return null;
                  })
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: addCourse, child: const Text("Add")),
        ]));
  }

  void addCourse({Course? course}) async {
    if (!validate()) return;
    await addNewCourse(AddCourseParams(
      sermersers: int.tryParse(semesterController.text) ?? 4,
      id: course?.id,
      university: university!.id,
      name: courseNameController.text,
    ));
    getCourses();
    popDialog();
  }

  editCourse(Course course) async {
    if (!formKey.currentState!.validate()) return;
    await addNewCourse(AddCourseParams(
      sermersers: int.tryParse(semesterController.text) ?? 4,
      id: course.id,
      university: course.university.id,
      name: courseNameController.text,
    ));
    getCourses();
    popDialog();
  }

  deleteSelectedCourse(Course e) async {
    await deleteCourse(e);
    getCourses();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'course_form_key');
  bool validate() {
    bool valid = false;
    if (!formKey.currentState!.validate()) return valid;
    if (university == null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text("Please select university"),
      ));
      return valid;
    }
    valid = true;
    return valid;
  }

  showEditCourseDialog(Course e) {
    courseNameController.text = e.name;
    semesterController.text = e.semesters.toString();
    // getUniversities(universityId: e.university);

    Get.dialog(AlertDialog(
        title: const Text("Edit Course"),
        content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: courseNameController,
                  decoration: const InputDecoration(
                    labelText: "Course Name",
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Enter Course Name" : null,
                ),
                TextFormField(
                    controller: semesterController,
                    decoration: const InputDecoration(
                      labelText: "Semesters",
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Semesters is required";
                      }
                      final semester = int.tryParse(value);
                      if (semester == null) {
                        return "Semesters must be a number";
                      }
                      if (semester < 1 || semester > 8) {
                        return "Semesters must be between 1 and 8";
                      }
                      return null;
                    })
              ],
            )),
        actions: [
          ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => editCourse(e), child: const Text("Save")),
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

  selectCourse(Course course) {
    selectedCourse = course;
    notifyListeners();
  }
}
