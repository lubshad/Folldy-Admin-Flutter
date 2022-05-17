import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';

import 'package:folldy_admin/domain/usecase/delete_presentation.dart';
import 'package:folldy_admin/domain/usecase/get_all_areas.dart';
import 'package:folldy_admin/domain/usecase/get_all_presentations.dart';
import 'package:folldy_admin/presentation/dialogs/add_presentation_dialog/add_presentation_dialog.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/presentation_list_response.dart';

class PresentationsListingController extends ChangeNotifier {
  TextEditingController searchPresentationController = TextEditingController();
  GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());
  GetAllAreas getAllAreas = GetAllAreas(Get.find());

  DeletePresentation deletePresentation = DeletePresentation(Get.find());

  List<Presentation> presentations = [];
  List<Area> areas = [];

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
    appError = null;
    makeLoading();
    getPresentations();
  }

  getPresentations() async {
    appError = null;
    final response = await getAllPresentations(PresentationListingParams(
        searchKey: searchPresentationController.text));
    response.fold((l) => appError = l, (r) => presentations = r);
    makeNotLoading();
  }

  getAreas() async {
    final response = await getAllAreas(NoParams());
    response.fold((l) => l.handleError(), (r) => areas = r);
    // notifyListeners();
  }

  showAddPresentationDialog() {
    getAreas();
    Get.dialog(AddPresentationDialog(presentationsListingController: this));
  }

  deleteSelectedPresentation(Presentation e) async {
    final response = await deletePresentation(e);
    response.fold((l) => l.handleError(), (r) => getPresentations());
  }

  showDeletePresentationConfirmation(Presentation e) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Presentation'),
        content: Text('Are you sure you want to delete ${e.name} ?'),
        actions: [
          ElevatedButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteSelectedPresentation(e);
              Get.back();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
