import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/domain/usecase/get_all_areas.dart';

class AreaSelectionController extends ChangeNotifier {
  final int? chapterId;
  final int? subjectId;
  AreaSelectionController({this.chapterId, this.subjectId});

  GetAllAreas getAllArea = GetAllAreas(Get.find());
  TextEditingController searchAreaController = TextEditingController();

  List<Area> selectedArea = [];

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

  List<Area> areas = [];

  getArea() async {
    appError = null;
    final response = await getAllArea(
        AreaListingParams(searchKey: searchAreaController.text));
    response.fold((l) => appError = l, (r) => areas = r);
    makeNotLoading();
  }

  void selectArea(Area presentation) {
    if (selectedArea.contains(presentation)) {
      selectedArea.remove(presentation);
    } else {
      selectedArea.add(presentation);
    }
    notifyListeners();
  }

  selectionValue(Area presentation) =>
      selectedArea.map((e) => e.id).contains(presentation.id);

  onChanged(Area presentation) {
    selectedArea.map((e) => e.id).contains(presentation.id)
        ? selectedArea
            .removeWhere((selecteArea) => selecteArea.id == presentation.id)
        : selectedArea.add(presentation);
    notifyListeners();
  }

  void clear() {
    selectedArea.clear();
    notifyListeners();
  }
}
