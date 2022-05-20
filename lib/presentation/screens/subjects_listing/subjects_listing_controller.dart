import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/domain/usecase/delete_subject.dart';
import 'package:folldy_admin/domain/usecase/get_all_subjects.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/subject_list_response.dart';
import '../../../domain/usecase/add_subject.dart';

class SubjectListingController extends ChangeNotifier {
  Course? course;
  int? semester;
  GetAllSubjects getAllSubjects = GetAllSubjects(Get.find());
  // GetAllCourses getAllCourses = GetAllCourses(Get.find());
  AddNewSubject addNewSubject = AddNewSubject(Get.find());
  DeleteSubject deleteSubject = DeleteSubject(Get.find());

  TextEditingController subjectNameController = TextEditingController();
  TextEditingController searchSubjectController = TextEditingController();
  // TextEditingController semesterController = TextEditingController();
  List<Subject> subjects = [];
  // List<Course> cources = [];
  // List<Institution> institutes = [];

  // Course? selectedCourse;
  // Institution? selectedInstitution;
  bool? appError;
  bool isLoading = true;

  // get courcesItems => cources
  //     .map((e) => DropdownMenuItem<Course>(value: e, child: Text(e.name)))
  //     .toList();

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
    final response = await getAllSubjects(SubjectListingParams(
        courseId: course?.id, searchKey: searchSubjectController.text));
    response.fold((l) => l.handleError(), (r) => subjects = r);
    makeNotLoading();
  }

  // getCourses() async {
  //   final response = await getAllCourses(NoParams());
  //   response.fold((l) => l.handleError(), (r) => cources = r);
  //   notifyListeners();
  // }

  showAddSubjectDialog() {
    subjectNameController.clear();
    // semesterController.clear();
    Get.dialog(AlertDialog(
        title: const Text("Add New Subject"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: subjectNameController,
                decoration: const InputDecoration(
                  labelText: "Subject Name",
                ),
                onFieldSubmitted: (val) => addSubject(),
                validator: (value) =>
                    value!.isEmpty ? "Subject Name is required" : null,
              ),
              // TextFormField(
              //     controller: semesterController,
              //     decoration: const InputDecoration(
              //       labelText: "Semester",
              //     ),
              //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return null;
              //       }
              //       final semester = int.tryParse(value);
              //       if (semester == null) {
              //         return "Semester must be a number";
              //       }
              //       if (semester < 1 || semester > 8) {
              //         return "Semester must be between 1 and 8";
              //       }
              //       return null;
              //     })
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: addSubject, child: const Text("Add")),
        ]));
  }

  void addSubject({Subject? subject}) async {
    if (!formKey.currentState!.validate()) return;
    await addNewSubject(AddSubjectParams(
        name: subjectNameController.text,
        id: subject?.id,
        semester: semester!,
        course: course!.id!));
    getData();
    popDialog();
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'subject_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  showEditSubjectDialog(Subject subject) {
    subjectNameController.text = subject.name;
    // semesterController.text = subject.semester.toString();
    Get.dialog(AlertDialog(
        title: const Text("Edit Subject"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: subjectNameController,
                decoration: const InputDecoration(
                  labelText: "Subject Name",
                ),
                onFieldSubmitted: (val) => addSubject(subject: subject),
                validator: (value) =>
                    value!.isEmpty ? "Subject Name is required" : null,
              ),
              // TextFormField(
              //     controller: semesterController,
              //     decoration: const InputDecoration(
              //       labelText: "Semester",
              //     ),
              //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return null;
              //       }
              //       final semester = int.tryParse(value);
              //       if (semester == null) {
              //         return "Semester must be a number";
              //       }
              //       if (semester < 1 || semester > 8) {
              //         return "Semester must be between 1 and 8";
              //       }
              //       return null;
              //     })
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => editSubject(subject), child: const Text("Save")),
        ]));
  }

  showDeleteSubjectConfirmation(Subject subject) {
    Get.dialog(AlertDialog(
        title: const Text("Delete Subject"),
        content: Text("Are you sure you want to delete ${subject.name}?"),
        actions: [
          ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                await deleteSubject(subject);
                getData();
                popDialog();
              },
              child: const Text("Delete")),
        ]));
  }

  editSubject(Subject subject) async {
    if (!formKey.currentState!.validate()) return;
    await addNewSubject(AddSubjectParams(
        name: subjectNameController.text,
        id: subject.id,
        semester: subject.semester,
        course: subject.course.id!));
    getData();
    popDialog();
  }
}
