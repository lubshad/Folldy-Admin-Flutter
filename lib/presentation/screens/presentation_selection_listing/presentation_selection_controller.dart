import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/domain/usecase/get_area_wise_presentation.dart';

class PresentationSelectionController extends ChangeNotifier {
  // GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());
  GetAreawisePresentaions getAreawisePresentaions =
      GetAreawisePresentaions(Get.find());
  TextEditingController searchPresentationController = TextEditingController();

  Set<Map<String, dynamic>> selectedPresentations = {};

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

  List<dynamic> areavisePresentations = [];

  getPresentations() async {
    appError = null;
    final response = await getAreawisePresentaions(NoParams());
    response.fold((l) => appError = l, (r) {
      for (Map<String, dynamic> area in r) {
        List presentations = area["presentations"];
        List<int> modules =
            presentations.map((e) => e["module"] as int).toSet().toList();
        modules.sort();
        List<Map<String, dynamic>> modulevisePresentations = [];
        for (int module in modules) {
          List modulePresentations = [];
          modulePresentations =
              presentations.where((e) => e["module"] == module).toList();
          modulevisePresentations.add({
            "module": "Module $module",
            "presentations": modulePresentations
          });
        }
        area.remove("presentations");
        area["modules"] = modulevisePresentations;
      }
      areavisePresentations = r;
    });
    makeNotLoading();
  }

  void selectPresentation(Map<String, dynamic> presentation) {
    if (selectedPresentations
        .map((e) => e["id"])
        .toList()
        .contains(presentation["id"])) {
      selectedPresentations
          .removeWhere((element) => element["id"] == presentation["id"]);
    } else {
      selectedPresentations.add(presentation);
    }
    notifyListeners();
  }

  selectionValue(Map<String, dynamic> presentation) =>
      selectedPresentations.map((e) => e["id"]).contains(presentation["id"]);

  void clear() {
    selectedPresentations.clear();
    notifyListeners();
  }

  moduleSelectionStatus(List presentations) {
    return selectedPresentations
            .map((e) => e["id"])
            .toSet()
            .containsAll(presentations.map((e) => e["id"]).toSet())
        ? true
        : false;
  }

  selectModule(List presentations, bool? value) {
    if (value == true) {
      selectedPresentations.addAll(presentations.map((e) => e));
    } else {
      selectedPresentations.removeWhere((element) =>
          presentations.map((e) => e["id"]).contains(element["id"]));
    }
    notifyListeners();
  }
}
