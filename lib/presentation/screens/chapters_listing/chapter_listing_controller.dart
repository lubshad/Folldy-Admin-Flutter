import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/usecase/add_new_chapter.dart';
import 'package:folldy_admin/domain/usecase/delete_chapter.dart';
import 'package:folldy_admin/domain/usecase/get_all_chapters.dart';
import 'package:get/get.dart';

import '../../../data/models/chapter_list_response.dart';
import '../../../data/models/subject_list_response.dart';
import '../../../domain/usecase/get_all_subjects.dart';

class ChapterListingController extends ChangeNotifier {
  GetAllChapters getAllChapters = GetAllChapters(Get.find());
  GetAllSubjects getAllSubjects = GetAllSubjects(Get.find());
  AddNewChapter addNewChapter = AddNewChapter(Get.find());
  DeleteChapter deleteChapter = DeleteChapter(Get.find());

  ChapterListingController() {
    getData();
  }

  TextEditingController chapterNameController = TextEditingController();
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
                    controller: chapterNameController,
                    decoration: const InputDecoration(
                      labelText: "Chapter Name",
                    ),
                    onFieldSubmitted: (val) => addChapter(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(onPressed: addChapter, child: const Text("Add")),
              ]);
        });
  }

  void addChapter() async {
    await addNewChapter(Chapter(
        subject: selectedSubject!.id, name: chapterNameController.text, id: 1));
    chapterNameController.clear();
    getData();
  }

  deleteSelectedChapter(Chapter e) async {
    await deleteChapter(e);
    getData();
  }

  void changeSelectedSubject(Subject? value) {
    selectedSubject = value;
    notifyListeners();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }

  void getData() {
    getChapters();
    getSubjects();
  }

  void getChapters() async {
    final response = await getAllChapters(NoParams());
    response.fold((l) => l.handleError(), (r) => chapters = r);
    notifyListeners();
  }

  void getSubjects() async {
    final response = await getAllSubjects(NoParams());
    response.fold((l) => l.handleError(), (r) => subjects = r);
    notifyListeners();
  }
}
