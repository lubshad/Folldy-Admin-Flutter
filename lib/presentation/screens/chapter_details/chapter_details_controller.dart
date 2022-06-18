import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/utils/extensions.dart';
import 'package:folldy_utils/data/models/chapter_list_response.dart';
import 'package:folldy_utils/data/models/presentation_list_response.dart';
import 'package:folldy_utils/domain/usecase/add_presentation_to_chapter.dart';
import 'package:folldy_utils/domain/usecase/get_chapter_presentations.dart';
import 'package:folldy_utils/domain/usecase/remove_presentation_from_chapter.dart';
import 'package:folldy_utils/domain/usecase/update_chapter_presentation_display_order.dart';

class ChapterDetailsController extends ChangeNotifier {
  AddPresentations addPresentationToChapter = AddPresentations(Get.find());
  GetChapterPresentations getChapterPresentations =
      GetChapterPresentations(Get.find());
  UpdateChapterPresentationDisplayOrder updateChapterPresentationDisplayOrder =
      UpdateChapterPresentationDisplayOrder(Get.find());
  RemovePresentationFromChapter removePresentationFromChapter =
      RemovePresentationFromChapter(Get.find());

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
    final response = await getChapterPresentations(
        GetChapterPresentationsParams(chapterId: chapter!.id!));
    response.fold((l) => l.handleError(), (r) {
      presentations = presentationListResponseFromJson(r);
      presentations
          .sort((a, b) => (a.displayOrder ?? 1) - (b.displayOrder ?? 1));
    });
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

  updateDisplayOrder(
      {required Presentation drop, required Presentation droppedOn}) async {
    int dropIndex = presentations.indexOf(drop);
    int droppedOnIndex = presentations.indexOf(droppedOn);
    if (dropIndex < droppedOnIndex) {
      presentations.insert(droppedOnIndex + 1, drop);
      presentations.removeAt(dropIndex);
    } else {
      presentations.insert(droppedOnIndex, drop);
      presentations.removeAt(dropIndex + 1);
    }
    notifyListeners();
    final response = await updateChapterPresentationDisplayOrder(
        UpdateChapterPresentationDisplayOrderParams(
            chapterId: chapter!.id!,
            presentationIds: presentations.map((e) => e.id).toList()));
    response.fold((l) => l.handleError(), (r) => {});
  }

  removeFromChapter(Presentation presentation) async {
    final response = await removePresentationFromChapter(
        RemovePresentationFromChapterParams(
            chapterId: chapter!.id!, presentationId: presentation.id));
    response.fold((l) => l.handleError(), (r) => getData());
  }

  showRemovePresentationConfirmationDialog(Presentation presentation) {
    Get.dialog(
      AlertDialog(
        title: const Text("Remove Presentation"),
        content: Text("Are you sure you want to remove ${presentation.name}?"),
        actions: [
          ElevatedButton(
            child: const Text("Cancel"),
            onPressed: () => Get.back(),
          ),
          ElevatedButton(
            child: const Text("Remove"),
            onPressed: () {
              removeFromChapter(presentation);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
