import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';

import 'package:folldy_admin/domain/usecase/add_topic.dart';
import 'package:folldy_admin/domain/usecase/delete_topic.dart';
import 'package:folldy_admin/domain/usecase/get_all_chapters.dart';
import 'package:folldy_admin/domain/usecase/get_all_topics.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/chapter_list_response.dart';
import '../../../data/models/topic_list_response.dart';

class TopicListingController extends ChangeNotifier {
  TopicListingController() {
    getData();
  }

  GetAllTopics getAllTopics = GetAllTopics(Get.find());
  GetAllChapters getAllChapters = GetAllChapters(Get.find());
  AddNewTopic addNewTopic = AddNewTopic(Get.find());
  DeleteTopic deleteTopic = DeleteTopic(Get.find());

  TextEditingController topicNameController = TextEditingController();
  List<Topic> topics = [];
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

  getTopics() async {
    final response = await getAllTopics(NoParams());
    response.fold((l) => l.handleError(), (r) => topics = r);
    notifyListeners();
  }

  getChapters() async {
    final response = await getAllChapters(NoParams());
    response.fold((l) => l.handleError(), (r) => chapters = r);
    notifyListeners();
  }

  showAddTopicDialog() {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New Topic"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<Chapter>(
                      decoration: const InputDecoration(
                        hintText: "Select Chapter",
                      ),
                      items: chaptersItems,
                      onChanged: changeSelectedChapter),
                  TextFormField(
                    controller: topicNameController,
                    decoration: const InputDecoration(
                      labelText: "Topic Name",
                    ),
                    onFieldSubmitted: (val) => addTopic(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(onPressed: addTopic, child: const Text("Add")),
              ]);
        });
  }

  void addTopic() async {
    await addNewTopic(Topic(
        chapter: selectedChapter!.id!, name: topicNameController.text, id: 1));
    topicNameController.clear();
    getData();
  }

  deleteSelectedTopic(Topic e) async {
    final response = await deleteTopic(e);
    response.fold((l) => l.handleError(), (r) => getData());
  }

  void changeSelectedChapter(Chapter? value) {
    selectedChapter = value;
    notifyListeners();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }

  void getData() {
    getChapters();
    getTopics();
  }
}
