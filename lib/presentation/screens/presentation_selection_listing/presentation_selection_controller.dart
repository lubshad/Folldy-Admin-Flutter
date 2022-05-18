import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/domain/usecase/get_all_presentations.dart';
import 'package:folldy_admin/presentation/screens/chapter_details/chapter_details_controller.dart';

import '../../../data/models/presentation_list_response.dart';

class PresentationSelectionController extends ChangeNotifier {
  GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());
  ChapterDetailsController chapterDetailsController = Get.find();
  TextEditingController searchPresentationController = TextEditingController();

  List<Presentation> selectedPresentations = [];

  void addPresentation() {}

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

  List<Presentation> presentations = [];

  getPresentations() async {
    appError = null;
    final response = await getAllPresentations(PresentationListingParams(
        searchKey: searchPresentationController.text));
    response.fold((l) => appError = l, (r) => presentations = r);
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

  void addPresentations() {
    chapterDetailsController.addPresntations(selectedPresentations);
  }
}
