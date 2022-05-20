import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/domain/usecase/get_area_wise_presentation.dart';

import '../../../data/models/presentation_list_response.dart';

class PresentationSelectionController extends ChangeNotifier {
  // GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());
  GetAreawisePresentaions getAreawisePresentaions =
      GetAreawisePresentaions(Get.find());
  TextEditingController searchPresentationController = TextEditingController();

  List<Presentation> selectedPresentations = [];

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
    response.fold((l) => appError = l, (r) => areavisePresentations = r);
    makeNotLoading();
  }

  void selectPresentation(Presentation presentation) {
    if (selectedPresentations.contains(presentation)) {
      selectedPresentations.remove(presentation);
    } else {
      selectedPresentations.add(presentation);
    }
    notifyListeners();
  }

  selectionValue(Presentation presentation) =>
      selectedPresentations.map((e) => e.id).contains(presentation.id);

  onChanged(Presentation presentation) {
    selectedPresentations.map((e) => e.id).contains(presentation.id)
        ? selectedPresentations.removeWhere(
            (selectePresentation) => selectePresentation.id == presentation.id)
        : selectedPresentations.add(presentation);
    notifyListeners();
  }

  void clear() {
    selectedPresentations.clear();
    notifyListeners();
  }
}
