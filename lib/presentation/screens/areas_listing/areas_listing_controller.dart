import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/usecase/add_new_area.dart';
import 'package:folldy_admin/domain/usecase/delete_area.dart';
import 'package:folldy_admin/domain/usecase/get_all_areas.dart';
import 'package:get/get.dart';

import '../../../data/models/chapter_list_response.dart';

class AreasListingController extends ChangeNotifier {
  AreasListingController() {
    getData();
  }

  GetAllAreas getAllAreas = GetAllAreas(Get.find());
  AddNewArea addNewArea = AddNewArea(Get.find());
  DeleteArea deleteArea = DeleteArea(Get.find());

  TextEditingController areaNameController = TextEditingController();
  final formKey = GlobalKey<FormState>(debugLabel: 'area_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  List<Area> areas = [];

  Chapter? selectedChapter;
  Institution? selectedInstitution;
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

  getAreas() async {
    final response = await getAllAreas(NoParams());
    response.fold((l) => l.handleError(), (r) => areas = r);
    notifyListeners();
  }

  showAddAreaDialog() {
    Get.dialog(AlertDialog(
        title: const Text("Add New Area"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autofocus: true,
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Please enter area name';
                  }
                  return null;
                },
                controller: areaNameController,
                decoration: const InputDecoration(
                  labelText: "Area Name",
                ),
                onFieldSubmitted: (val) => addArea(),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(onPressed: addArea, child: const Text("Add")),
        ]));
  }

  void addArea() async {
    if (!validate()) return;
    final response =
        await addNewArea(Area(name: areaNameController.text, id: 1));
    if (Get.isDialogOpen == true) Get.back();
    response.fold((l) => l.handleError(), (r) => getData());
    // areaNameController.clear();
  }

  deleteSelectedArea(Area e) async {
    final response = await deleteArea(e);
    response.fold((l) => l.handleError(), (r) => getData());
  }

  void getData() {
    getAreas();
  }
}
