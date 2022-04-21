import 'dart:async';

import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/domain/entities/no_params.dart';
import 'package:folldy_admin/domain/usecase/delete_presentation.dart';
import 'package:folldy_admin/domain/usecase/get_all_areas.dart';
import 'package:folldy_admin/domain/usecase/get_all_presentations.dart';
import 'package:folldy_admin/presentation/dialogs/add_presentation_dialog.dart';
import 'package:get/get.dart';

import '../../../data/models/presentation_list_response.dart';

class PresentationsListingController extends ChangeNotifier {
  PresentationsListingController() {
    getData();
  }

  GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());
  GetAllAreas getAllAreas = GetAllAreas(Get.find());

  DeletePresentation deletePresentation = DeletePresentation(Get.find());

  List<Presentation> presentations = [];
  List<Area> areas = [];

  bool? appError;
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

  getPresentations() async {
    final response = await getAllPresentations(NoParams());
    response.fold((l) => l.handleError(), (r) => presentations = r);
    notifyListeners();
  }

  getAreas() async {
    final response = await getAllAreas(NoParams());
    response.fold((l) => l.handleError(), (r) => areas = r);
    notifyListeners();
  }

  showAddPresentationDialog() {
    Get.dialog(AddPresentationDialog(presentationsListingController: this));
  }

  deleteSelectedPresentation(Presentation e) async {
    final response = await deletePresentation(e);
    response.fold((l) => l.handleError(), (r) => getData());
  }

  void getData() {
    getAreas();
    getPresentations();
  }
}
