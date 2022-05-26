import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/universities_listing/universities_listing.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:folldy_utils/data/models/area_list_response.dart';
import 'package:folldy_utils/data/models/chapter_list_response.dart';
import 'package:folldy_utils/data/models/institution_list_response.dart';
import 'package:folldy_utils/domain/usecase/delete_area.dart';
import 'package:folldy_utils/domain/usecase/get_all_areas.dart';
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
    final response = await getAllAreas(AreaListingParams());
    response.fold((l) => l.handleError(), (r) => areas = r);
    makeNotLoading();
  }

  showAddEditAreaDialog({Area? area}) async {
    Get.dialog( AddEditAreaDialog(area: area , getAreas: getAreas,));
  }

  deleteSelectedArea(Area e) async {
    final response = await deleteArea(e);
    response.fold((l) => l.handleError(), (r) => getAreas());
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

  Area? selectedArea;

  selectArea(Area? area) {
    selectedArea = area;
    notifyListeners();
  }

  selectionValue(Area area) {
    return selectedArea?.id == area.id;
  }

  onDropdownSelection(PopupOptions value, Area area) {
    switch (value) {
      case PopupOptions.edit:
        showAddEditAreaDialog(area:  area);
        break;
      case PopupOptions.delete:
        showAreaDeleteConfirmation(area);
        break;
    }
  }
}
