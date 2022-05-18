import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/domain/usecase/get_all_presentations.dart';

import '../../../data/models/presentation_list_response.dart';

class PresentationSelectionController extends ChangeNotifier {
  final int? chapterId;
  final int? subjectId;
  PresentationSelectionController({this.chapterId, this.subjectId});

  GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());
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

  List<Presentation> presentations = [];

  getPresentations() async {
    appError = null;
    final response = await getAllPresentations(PresentationListingParams(
        subjectId: subjectId,
        chapterId: chapterId,
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
}
