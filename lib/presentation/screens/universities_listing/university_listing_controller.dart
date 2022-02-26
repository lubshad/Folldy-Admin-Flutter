import 'package:flutter/material.dart';
import 'package:folldy_admin/data/remote_data_source.dart';
import 'package:get/get.dart';

import '../../../data/models/university_list_response.dart';

class UniversityListingController extends ChangeNotifier {
  UniversityListingController() {
    getData();
  }

  TextEditingController universityNameController = TextEditingController();
  List<University> universities = [];
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

  getData() async {
    universities = await RemoteDataSource.getAllUnivresity();
    notifyListeners();
  }

  showAddUniversityDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New University"),
              content: TextField(
                onSubmitted: (value) => addNewUniversity(),
                controller: universityNameController,
                decoration: const InputDecoration(
                  labelText: "University Name",
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: addNewUniversity, child: const Text("Add")),
              ]);
        });
  }

  void addNewUniversity() async {
    await RemoteDataSource.addUniversity(universityNameController.text);
    universityNameController.clear();
    getData();
  }

  deleteUniversity(University e) async {
    await RemoteDataSource.deleteUniversity(e.id);
    getData();
  }
}
