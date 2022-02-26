import 'package:flutter/material.dart';
import 'package:folldy_admin/data/remote_data_source.dart';
import 'package:get/get.dart';

import '../../../data/models/institution_list_response.dart';
import '../../../data/models/university_list_response.dart';

class InstitutionListingController extends ChangeNotifier {
  InstitutionListingController() {
    getUniversities();
    getData();
  }

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
    institutions = await RemoteDataSource.getAllInstitutions();
    notifyListeners();
  }

  getUniversities() async {
    universities = await RemoteDataSource.getAllUnivresity();
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
                    onSubmitted: (value) => addNewinstitution(),
                    controller: institutionNameController,
                    decoration: const InputDecoration(
                      labelText: "institution Name",
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: addNewinstitution, child: const Text("Add")),
              ]);
        });
  }

  void addNewinstitution() async {
    await RemoteDataSource.addInstitution(
        institutionNameController.text, selectedUniversity!.id);
    institutionNameController.clear();
    getData();
  }

  deleteInstitution(Institution e) async {
    await RemoteDataSource.deleteInstitution(e.id);
    getData();
  }

  void changeSelectedUniversity(University? value) {
    selectedUniversity = value;
  }
}
