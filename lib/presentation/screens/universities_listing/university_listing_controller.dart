import 'package:flutter/material.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/usecase/add_new_university.dart';
import 'package:folldy_admin/domain/usecase/delete_university.dart';
import 'package:folldy_admin/domain/usecase/get_all_universities.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/university_list_response.dart';

class UniversityListingController extends ChangeNotifier {
  GetAllUniversitys getAllUniversitys = GetAllUniversitys(Get.find());
  DeleteUniversity deleteUniversity = DeleteUniversity(Get.find());
  AddNewUniversity addNewUniversity = AddNewUniversity(Get.find());

  TextEditingController universityNameController = TextEditingController();
  List<University> universities = [];
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

  getData() async {
    final response = await getAllUniversitys(NoParams());
    response.fold((l) => appError = l, (r) => universities = r);
    makeNotLoading();
  }

  showAddUniversityDialog() {
    universityNameController.clear();
    Get.dialog(AlertDialog(
        title: const Text("Add New University"),
        content: Form(
          key: formKey,
          child: TextFormField(
            validator: (value) =>
                value!.isEmpty ? "Enter University Name" : null,
            onFieldSubmitted: (value) => addUniversity(),
            controller: universityNameController,
            decoration: const InputDecoration(
              labelText: "University Name",
            ),
          ),
        ),
        actions: [
          ElevatedButton(onPressed: addUniversity, child: const Text("Add")),
        ]));
  }

  void addUniversity() async {
    if (!formKey.currentState!.validate()) return;
    await addNewUniversity(
        University(name: universityNameController.text));
    getData();
    popDialog();
  }

  deleteSelectedUniversity(University e) async {
    final response = await deleteUniversity(e);
    response.fold((l) => l.handleError(), (r) => getData());
    popDialog();
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'university_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  void showDeleteUniversityConfirmation(University university) {
    Get.dialog(AlertDialog(
      title: const Text("Delete University"),
      content: Text("Are you sure you want to delete ${university.name}?"),
      actions: [
        ElevatedButton(
          onPressed: Get.back,
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => deleteSelectedUniversity(university),
          child: const Text("Delete"),
        ),
      ],
    ));
  }

  showEditUniversityDialog(University university) {
    universityNameController.text = university.name;
    Get.dialog(AlertDialog(
      title: const Text("Edit University"),
      content: Form(
        key: formKey,
        child: TextFormField(
          validator: (value) => value!.isEmpty ? "Enter University Name" : null,
          onFieldSubmitted: (value) => editUniversity(university),
          controller: universityNameController,
          decoration: const InputDecoration(
            labelText: "University Name",
          ),
        ),
      ),
      actions: [
        ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () => editUniversity(university),
          child: const Text("Save"),
        ),
      ],
    ));
  }

  editUniversity(University university) async {
    final response = await addNewUniversity(
        University(name: universityNameController.text, id: university.id));
    response.fold((l) => l.handleError(), (r) => getData());
    popDialog();
  }
}
