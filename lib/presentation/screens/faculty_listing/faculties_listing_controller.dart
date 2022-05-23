import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/chapter_list_response.dart';
import '../../../data/models/faculty_list_response.dart';
import '../../../domain/usecase/add_new_faculty.dart';
import '../../../domain/usecase/delete_faculty.dart';
import '../../../domain/usecase/get_all_facultys.dart';

class FacultyListingController extends ChangeNotifier {
  GetAllFacultys getAllFacultys = GetAllFacultys(Get.find());
  AddNewFaculty addNewFaculty = AddNewFaculty(Get.find());
  DeleteFaculty deleteFaculty = DeleteFaculty(Get.find());

  TextEditingController facultyNameController = TextEditingController();
  List<Faculty> faculties = [];
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

  getFacultys() async {
    final response = await getAllFacultys(NoParams());
    response.fold((l) => l.handleError(), (r) => faculties = r);
    makeNotLoading();
  }

  deleteSelectedFaculty(Faculty e) async {
    final response = await deleteFaculty(e);
    response.fold((l) => l.handleError(), (r) => getFacultys());
  }

  void changeSelectedChapter(Chapter? value) {
    selectedChapter = value;
    notifyListeners();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }

  void getData() {
    getFacultys();
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'faculty_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  TextEditingController facultyPhoneController = TextEditingController();

  void showAddEditFacultyDialog({Faculty? faculty}) {
    if (faculty == null) {
      facultyNameController.clear();
      facultyPhoneController.clear();
    } else {
      facultyNameController.text = faculty.name.toString();
      facultyPhoneController.text = faculty.phone.toString();
    }
    Get.dialog(AlertDialog(
        title: Text(faculty == null ? "Add New Faculty" : "edit Faculty"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: facultyNameController,
                decoration: const InputDecoration(
                  labelText: "Faculty Name",
                ),
                // onFieldSubmitted: (val) => addEditFaculty(faculty: faculty),
              ),
              TextFormField(
                  controller: facultyPhoneController,
                  decoration: const InputDecoration(
                    labelText: "Faculty Phone",
                  ),
                  onFieldSubmitted: (val) => addEditFaculty(faculty: faculty)),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () => addEditFaculty(faculty: faculty),
              child: Text(faculty == null ? "Add" : "Save")),
        ]));
  }

  showDeleteConfirmationDialog(Faculty faculty) {
    Get.dialog(AlertDialog(
        title: const Text("Delete Faculty"),
        content: Text("Are you sure you want to delete ${faculty.name}?"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                deleteSelectedFaculty(faculty);
                Get.back();
              },
              child: const Text("Delete")),
        ]));
  }

  addEditFaculty({Faculty? faculty}) async {
    final response = await addNewFaculty(AddFacultyParams(
        id: faculty?.id,
        name: facultyNameController.text,
        phone: facultyPhoneController.text));
    response.fold((l) => l.handleError(), (r) {
      popDialog();
      getFacultys();
    });
  }
}
