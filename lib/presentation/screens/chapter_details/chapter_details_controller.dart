import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/domain/usecase/add_presentation_to_chapter.dart';
import 'package:folldy_admin/domain/usecase/get_all_presentations.dart';
import 'package:folldy_admin/utils/extensions.dart';

class ChapterDetailsController extends ChangeNotifier {
  AddPresentations addPresentationToChapter = AddPresentations(Get.find());

  GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());

  bool presentaionListing = false;

  Chapter? chapter;

  void touglePresentationListing() {
    presentaionListing = !presentaionListing;
    notifyListeners();
  }

  void addPresntations(List<Presentation> selectedPresentations) async {
    final response = await addPresentationToChapter(AddPresentaionParams(
        presentationIds: selectedPresentations.map((e) => e.id).toList(),
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

  getData() async {
    final response = await getAllPresentations(PresentationListingParams(
        chapterId: chapter?.id, subjectId: chapter?.subjectId));
    response.fold((l) => l.handleError(), (r) => presentations = r);
    makeNotLoading();
  }

  void init(Chapter value) {
    chapter = value;
    appError = null;
    presentaionListing = false;
    makeLoading();
    getData();
  }
}
