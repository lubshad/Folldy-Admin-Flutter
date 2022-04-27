import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';

import 'package:folldy_admin/domain/usecase/add_new_institution.dart';
import 'package:folldy_admin/domain/usecase/delete_institution.dart';
import 'package:folldy_admin/domain/usecase/get_all_institutions.dart';
import 'package:folldy_admin/domain/usecase/get_all_universities.dart';

import '../../../data/models/institution_list_response.dart';
import '../../../data/models/university_list_response.dart';

class InstitutionListingController extends ChangeNotifier {
  InstitutionListingController() {
    getData();
  }

  GetAllInstitutions getAllInstitutions = GetAllInstitutions(Get.find());
  GetAllUniversitys getAllUniversitys = GetAllUniversitys(Get.find());
  AddNewInstitution addNewInstitution = AddNewInstitution(Get.find());
  DeleteInstitution deleteInstitution = DeleteInstitution(Get.find());

  TextEditingController institutionNameController = TextEditingController();
  List<Institution> institutions = [];
  List<University> universities = [];

  University? selectedUniversity;
  bool? appError;
  bool isLoading = true;

  get universitiesItems => universities
      .map((e) => DropdownMenuItem<University>(value: e, child: Text(e.name)))
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

  getData() async {
    getInstitutions();
    getUniversities();
  }

  getInstitutions() async {
    final response = await getAllInstitutions(NoParams());
    response.fold((l) => l.handleError(), (r) => institutions = r);
    notifyListeners();
  }

  getUniversities() async {
    final response = await getAllUniversitys(NoParams());
    response.fold((l) => l.handleError(), (r) => universities = r);
    notifyListeners();
  }

  showAddinstitutionDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New institution"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<University>(
                      decoration: const InputDecoration(
                        hintText: "Select University",
                      ),
                      items: universitiesItems,
                      onChanged: changeSelectedUniversity),
                  TextField(
                    onSubmitted: (value) => addInstitution(),
                    controller: institutionNameController,
                    decoration: const InputDecoration(
                      labelText: "institution Name",
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: addInstitution, child: const Text("Add")),
              ]);
        });
  }

  void addInstitution() async {
    await addNewInstitution(Institution(
        university: selectedUniversity!.id,
        name: institutionNameController.text,
        id: 1));
    institutionNameController.clear();
    getData();
  }

  deleteSelectedInstitution(Institution e) async {
    await deleteInstitution(e);
    getData();
  }

  void changeSelectedUniversity(University? value) {
    selectedUniversity = value;
  }
}
