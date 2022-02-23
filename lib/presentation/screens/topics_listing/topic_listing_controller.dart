import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/data/remote_data_source.dart';
import 'package:get/get.dart';

import '../../../data/models/chapter_list_response.dart';
import '../../../data/models/topic_list_response.dart';

class TopicListingController extends ChangeNotifier {
  TopicListingController() {
    getChapters();
    getData();
  }

  TextEditingController courseNameController = TextEditingController();
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

  getData() async {
    topics = await RemoteDataSource.getAllTopics();
    notifyListeners();
  }

  getChapters() async {
    chapters = await RemoteDataSource.getAllChapters();
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
                    controller: courseNameController,
                    decoration: const InputDecoration(
                      labelText: "Topic Name",
                    ),
                    onFieldSubmitted: (val) => addNewTopic(),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: addNewTopic, child: const Text("Add")),
              ]);
        });
  }

  void addNewTopic() async {
    await RemoteDataSource.addTopic(
        courseNameController.text, selectedChapter!.id);
    courseNameController.clear();
    getData();
  }

  deleteTopic(Topic e) async {
    await RemoteDataSource.deleteTopic(e.id);
    getData();
  }

  void changeSelectedChapter(Chapter? value) {
    selectedChapter = value;
    notifyListeners();
  }

  void changeSelectedInstitute(Institution? value) {
    selectedInstitution = value;
  }
}
