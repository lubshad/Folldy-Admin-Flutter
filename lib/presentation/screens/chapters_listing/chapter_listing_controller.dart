import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/remote_data_source.dart';
import 'package:get/get.dart';

import '../../../data/models/chapter_list_response.dart';
import '../../../data/models/subject_list_response.dart';

class ChapterListingController extends ChangeNotifier {
  ChapterListingController() {
    getSubjects();
    getData();
  }

  TextEditingController courseNameController = TextEditingController();
  List<Chapter> chapters = [];
  List<Subject> subjects = [];
  // List<Institution> institutes = [];

  Subject? selectedSubject;
  Institution? selectedInstitution;
  bool? appError;
  bool isLoading = true;

  get subjectsItems => subjects
      .map((e) => DropdownMenuItem<Subject>(value: e, child: Text(e.name)))
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
    chapters = await RemoteDataSource.getAllChapters();
    notifyListeners();
  }

  getSubjects() async {
    subjects = await RemoteDataSource.getAllSubjects();
  }

  showAddChapterDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New Chapter"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Subject>(
                      decoration: const InputDecoration(
                        hintText: "Select Subject",
                      ),
                      items: subjectsItems,
                      onChanged: changeSelectedSubject),
                  TextFormField(
                    controller: courseNameController,
                    decoration: const InputDecoration(
                      labelText: "Chapter Name",
                    ),
                    onFieldSubmitted: (val) => addNewChapter(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: addNewChapter, child: const Text("Add")),
              ]);
        });
  }

  void addNewChapter() async {
    await RemoteDataSource.addChapter(
        courseNameController.text, selectedSubject!.id);
    courseNameController.clear();
    getData();
  }

  deleteChapter(Chapter e) async {
    await RemoteDataSource.deleteChapter(e.id);
    getData();
  }

  void changeSelectedSubject(Subject? value) {
    selectedSubject = value;
    notifyListeners();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }
}
