import 'package:flutter/material.dart';
import 'package:basic_template/basic_template.dart';

import 'package:folldy_admin/domain/usecase/add_new_university.dart';
import 'package:folldy_admin/domain/usecase/delete_university.dart';
import 'package:folldy_admin/domain/usecase/get_all_universities.dart';

import '../../../data/models/university_list_response.dart';

class UniversityListingController extends ChangeNotifier {
  UniversityListingController() {
    getData();
  }

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
    notifyListeners();
  }

  showAddUniversityDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New University"),
              content: TextField(
                onSubmitted: (value) => addUniversity(),
                controller: universityNameController,
                decoration: const InputDecoration(
                  labelText: "University Name",
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: addUniversity, child: const Text("Add")),
              ]);
        });
  }

  void addUniversity() async {
    await addNewUniversity(
        University(name: universityNameController.text, id: 1));
    universityNameController.clear();
    getData();
  }

  deleteSelectedUniversity(University e) async {
    final response = await deleteUniversity(e);
    response.fold((l) => l.handleError(), (r) => getData());
  }
}
