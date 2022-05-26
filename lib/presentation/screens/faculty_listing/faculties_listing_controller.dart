import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:folldy_admin/utils/validators.dart';
import 'package:folldy_utils/data/models/faculty_list_response.dart';
import 'package:folldy_utils/data/models/institution_list_response.dart';
import 'package:folldy_utils/domain/usecase/add_new_faculty.dart';
import 'package:folldy_utils/domain/usecase/delete_faculty.dart';
import 'package:folldy_utils/domain/usecase/get_all_facultys.dart';

class FacultyListingController extends ChangeNotifier {
  GetAllFacultys getAllFacultys = GetAllFacultys(Get.find());
  AddNewFaculty addNewFaculty = AddNewFaculty(Get.find());
  DeleteFaculty deleteFaculty = DeleteFaculty(Get.find());

  TextEditingController facultyNameController = TextEditingController();
  List<Faculty> faculties = [];

  Institution? selectedInstitution;
  AppError? appError;
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

  getFacultys() async {
    final response = await getAllFacultys(
        FacultyListingParams(institution: selectedInstitution?.id));
    response.fold((l) => l.handleError(), (r) => faculties = r);
    makeNotLoading();
  }

  deleteSelectedFaculty(Faculty e) async {
    final response = await deleteFaculty(e);
    response.fold((l) => l.handleError(), (r) => getFacultys());
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
        title: Text(faculty == null ? "Add New Faculty" : "Edit Faculty"),
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
                validator: (value) => value!.isEmpty
                    ? 'Please enter faculty name'
                    : value.length < 3
                        ? 'Please enter valid name'
                        : null,
              ),
              TextFormField(
                  validator: (value) => validatePhone(phone: value),
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
    if (!validate()) return;
    final response = await addNewFaculty(AddFacultyParams(
        institution: selectedInstitution!.id,
        id: faculty?.id,
        name: facultyNameController.text,
        phone: facultyPhoneController.text));
    response.fold((l) => l.handleError(), (r) => handleResponse(r));
  }

  handleResponse(Map<String, dynamic> r) {
    if (r["status"] == 0) {
      Map<String, dynamic> error = r["error"];
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text(error.entries.map((e) => e.value.toString()).join(", ")),
      ));
    } else {
      popDialog();
      getFacultys();
    }
  }
}
