import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:folldy_utils/data/models/chapter_list_response.dart';
import 'package:folldy_utils/data/models/presentation_list_response.dart';
import 'package:folldy_utils/domain/usecase/add_presentation_to_chapter.dart';
import 'package:folldy_utils/domain/usecase/get_all_presentations.dart';

class ChapterDetailsController extends ChangeNotifier {
  AddPresentations addPresentationToChapter = AddPresentations(Get.find());

  GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());

  bool presentaionListing = false;

  Chapter? chapter;

  void touglePresentationListing() {
    presentaionListing = !presentaionListing;
    notifyListeners();
  }

  void addPresntations(List<Map<String, dynamic>> selectedPresentations) async {
    final response = await addPresentationToChapter(AddPresentaionParams(
        presentationIds:
            selectedPresentations.map((e) => e["id"] as int).toList(),
        chapterId: chapter!.id!));
    response.fold((l) => l.handleError(), (r) => getData());
  }

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
  List<Map<String, dynamic>> moduleVisePresentations = [];
  getData() async {
    final response = await getAllPresentations(
        PresentationListingParams(chapterId: chapter?.id));
    response.fold((l) => l.handleError(),
        (r) => presentations = presentationListResponseFromJson(r));
    makeNotLoading();
  }

  void setModuleVisePresentations(List<dynamic> presentations) {
    List<int> modules =
        presentations.map((e) => e["module"] as int).toSet().toList();
    modules.sort();
    List<Map<String, dynamic>> newModuleVisePresentations = [];
    for (int module in modules) {
      List modulePresentations = [];
      modulePresentations =
          presentations.where((e) => e["module"] == module).toList();
      newModuleVisePresentations
          .add({"module": module, "presentations": modulePresentations});
    }
    moduleVisePresentations = newModuleVisePresentations;
  }

  void init(Chapter value) {
    chapter = value;
    appError = null;
    presentaionListing = false;
    makeLoading();
    getData();
  }
}
