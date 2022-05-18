import 'package:basic_template/basic_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/domain/usecase/add_presentation_to_chapter.dart';
import 'package:folldy_admin/domain/usecase/get_all_presentations.dart';
import 'package:folldy_admin/utils/extensions.dart';

class SubjectDetailsController extends ChangeNotifier {
  AddPresentations addPresentations = AddPresentations(Get.find());

  // AddAreaToSubject addAreaToSubject = AddAreaToSubject(Get.find());

  GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());

  bool presentaionListing = false;
  bool areaListing = false;

  Subject? subject;

  void touglePresentationListing() {
    presentaionListing = !presentaionListing;
    notifyListeners();
  }

  void addPresentationss(List<Presentation> selectedPresentations) async {
    final response = await addPresentations(AddPresentaionParams(
        presentationIds: selectedPresentations.map((e) => e.id).toList(),
        subjectId: subject!.id!));
    response.fold((l) => l.handleError(), (r) => getData());
  }

  void addAreas(List<Area> selectedAreas) async {
    final response = await addPresentations(AddPresentaionParams(
        subjectId: subject!.id!,
        areaIds: selectedAreas.map((e) => e.id).toList()));
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
      subjectId: subject!.id!,
    ));
    response.fold((l) => l.handleError(), (r) => presentations = r);
    makeNotLoading();
  }

  void init(Subject value) {
    subject = value;
    appError = null;
    presentaionListing = false;
    areaListing = false;
    makeLoading();
    getData();
  }

  void tougleAreaLising() {
    areaListing = !areaListing;
    notifyListeners();
  }
}
