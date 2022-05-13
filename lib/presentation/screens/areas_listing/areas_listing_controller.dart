import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/institution_list_response.dart';
import 'package:folldy_admin/domain/usecase/delete_area.dart';
import 'package:folldy_admin/domain/usecase/get_all_areas.dart';

import '../../../data/models/chapter_list_response.dart';
import '../../dialogs/add_new_area/add_new_area_dialog.dart';

class AreasListingController extends ChangeNotifier {
  GetAllAreas getAllAreas = GetAllAreas(Get.find());
  DeleteArea deleteArea = DeleteArea(Get.find());

  TextEditingController areaNameController = TextEditingController();
  TextEditingController searchAreaController = TextEditingController();
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

  getAreas() async {
    final response = await getAllAreas(NoParams());
    response.fold((l) => l.handleError(), (r) => areas = r);
    makeNotLoading();
  }

  showAddAreaDialog() {
    Get.dialog(const AddNewAreaDialog());
  }

  deleteSelectedArea(Area e) async {
    final response = await deleteArea(e);
    response.fold((l) => l.handleError(), (r) => getData());
  }

  void getData() {
    getAreas();
  }

  showAreaDeleteConfirmation(Area e) {
    Get.dialog(
      AlertDialog(
        title: const Text("Delete Area"),
        content: Text("Are you sure you want to delete ${e.name} ?"),
        actions: [
          ElevatedButton(
            onPressed: Get.back,
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              deleteSelectedArea(e);
              Get.back();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void search(String value) {}
}
