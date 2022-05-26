import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folldy_utils/data/models/chapter_list_response.dart';
import 'package:folldy_utils/data/models/subject_list_response.dart';

import 'package:folldy_utils/domain/usecase/add_new_chapter.dart';
import 'package:folldy_utils/domain/usecase/delete_chapter.dart';
import 'package:folldy_utils/domain/usecase/get_all_chapters.dart';
import 'package:folldy_admin/utils/extensions.dart';

class ChapterListingController extends ChangeNotifier {
  GetAllChapters getAllChapters = GetAllChapters(Get.find());
  // GetAllSubjects getAllSubjects = GetAllSubjects(Get.find());
  AddNewChapter addNewChapter = AddNewChapter(Get.find());
  DeleteChapter deleteChapter = DeleteChapter(Get.find());

  TextEditingController chapterNameController = TextEditingController();
  TextEditingController moduleController = TextEditingController();
  List<Chapter> chapters = [];
  // List<Subject> subjects = [];
  // List<Institution> institutes = [];

  // Subject? selectedSubject;
  // Institution? selectedInstitution;
  AppError? appError;
  bool isLoading = true;

  // get subjectsItems => subjects
  //     .map((e) => DropdownMenuItem<Subject>(value: e, child: Text(e.name)))
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

  final formKey = GlobalKey<FormState>(debugLabel: 'chapter_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  showAddChapterDialog() {
    chapterNameController.clear();
    moduleController.clear();
    Get.dialog(AlertDialog(
        title: const Text("Add New Chapter"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: chapterNameController,
                decoration: const InputDecoration(
                  labelText: "Chapter Name",
                ),
                onFieldSubmitted: (val) => addChapter(),
                validator: (value) =>
                    value!.isEmpty ? "Chapter name is required" : null,
              ),
              TextFormField(
                controller: moduleController,
                decoration: const InputDecoration(
                  labelText: "Module",
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) return null;
                  final module = int.tryParse(value);
                  if (module == null) return "Module must be a number";
                  if (module < 1) {
                    return "Module must be greater than 0";
                  }
                  return null;
                },
              )
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: addChapter, child: const Text("Add")),
        ]));
  }

  void addChapter({Chapter? chapter}) async {
    if (!formKey.currentState!.validate()) return;
    await addNewChapter(Chapter(
        subjectId: subject?.id,
        name: chapterNameController.text,
        id: chapter?.id,
        module: int.tryParse(moduleController.text) ?? 1));
    getData();
    popDialog();
  }

  // void changeSelectedSubject(Subject? value) {
  //   selectedSubject = value;
  //   notifyListeners();
  // }

  // void changeSelectedInstitute(Institution? value) {
  //   selectedInstitution = value;
  // }

  // void getData() {
  //   getChapters();
  //   // getSubjects();
  // }

  Subject? subject;

  void getData() async {
    final response =
        await getAllChapters(ChapterListingParams(subjectId: subject?.id));
    response.fold((l) => l.handleError(), (r) => chapters = r);
    makeNotLoading();
  }

  showEditChapterDialog(Chapter chapter) {
    chapterNameController.text = chapter.name;
    moduleController.text = chapter.module.toString();
    Get.dialog(AlertDialog(
        title: const Text("Edit Chapter"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: chapterNameController,
                decoration: const InputDecoration(
                  labelText: "Chapter Name",
                ),
                onFieldSubmitted: (val) => addChapter(chapter: chapter),
                validator: (value) =>
                    value!.isEmpty ? "Chapter name is required" : null,
              ),
              TextFormField(
                controller: moduleController,
                decoration: const InputDecoration(
                  labelText: "Module",
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) return null;
                  final module = int.tryParse(value);
                  if (module == null) return "Module must be a number";
                  if (module < 1) {
                    return "Module must be greater than 0";
                  }
                  return null;
                },
              )
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () => addChapter(chapter: chapter),
              child: const Text("Save")),
        ]));
  }

  showDeleteChapterConfirmationDialog(Chapter chapter) {
    Get.dialog(AlertDialog(
        title: const Text("Delete Chapter"),
        content: Text("Are you sure you want to delete ${chapter.name}?"),
        actions: [
          ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                await deleteChapter(chapter);
                getData();
                popDialog();
              },
              child: const Text("Delete")),
        ]));
  }

  void init(Subject value) {
    subject = value;
    getData();
  }
}
