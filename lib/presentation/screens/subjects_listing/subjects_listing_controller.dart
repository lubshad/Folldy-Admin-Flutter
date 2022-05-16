import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/domain/usecase/delete_subject.dart';
import 'package:folldy_admin/domain/usecase/get_all_subjects.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/subject_list_response.dart';
import '../../../domain/usecase/add_subject.dart';

class SubjectListingController extends ChangeNotifier {
  GetAllSubjects getAllSubjects = GetAllSubjects(Get.find());
  // GetAllCourses getAllCourses = GetAllCourses(Get.find());
  AddNewSubject addNewSubject = AddNewSubject(Get.find());
  DeleteSubject deleteSubject = DeleteSubject(Get.find());

  TextEditingController subjectNameController = TextEditingController();
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
    final response = await getAllSubjects(NoParams());
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
    Get.dialog(AlertDialog(
        title: const Text("Add New Subject"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // DropdownButtonFormField<Course>(
              //     decoration: const InputDecoration(
              //       hintText: "Select Course",
              //     ),
              //     items: courcesItems,
              //     onChanged: changeSelectedCourse),
              TextFormField(
                controller: subjectNameController,
                decoration: const InputDecoration(
                  labelText: "Subject Name",
                ),
                onFieldSubmitted: (val) => addSubject(),
                validator: (value) =>
                    value!.isEmpty ? "Subject Name is required" : null,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: addSubject, child: const Text("Add")),
        ]));
  }

  void addSubject({Subject? subject}) async {
    if (!formKey.currentState!.validate()) return;
    await addNewSubject(
        Subject(name: subjectNameController.text, id: subject?.id));
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
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => addSubject(subject: subject),
              child: const Text("Save")),
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
}
