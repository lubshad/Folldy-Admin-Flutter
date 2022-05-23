import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/domain/usecase/add_new_presentation.dart';

import 'package:folldy_admin/domain/usecase/delete_presentation.dart';
import 'package:folldy_admin/domain/usecase/get_all_areas.dart';
import 'package:folldy_admin/domain/usecase/get_all_presentations.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/presentation_list_response.dart';
import '../../theme/theme.dart';

class PresentationsListingController extends ChangeNotifier {
  TextEditingController searchPresentationController = TextEditingController();
  GetAllPresentations getAllPresentations = GetAllPresentations(Get.find());
  GetAllAreas getAllAreas = GetAllAreas(Get.find());
  Area? selectedArea;

  List<Map<String, dynamic>> moduleVisePresentations = [];

  DeletePresentation deletePresentation = DeletePresentation(Get.find());

  List<Presentation> presentations = [];
  List<Area> areas = [];

  AppError? appError;
  bool isLoading = true;

  int get totalPresentations => moduleVisePresentations
      .map((e) => e["presentations"])
      .expand((element) => element)
      .length;

  makeLoading() {
    isLoading = true;
    notifyListeners();
  }

  makeNotLoading() {
    isLoading = false;
    notifyListeners();
  }

  retry() async {
    appError = null;
    makeLoading();
    getPresentations();
  }

  getPresentations() async {
    appError = null;
    final response = await getAllPresentations(PresentationListingParams(
        // searchKey: searchPresentationController.text,
        areaId: selectedArea?.id));
    response.fold((l) => appError = l, (r) {
      setModuleVisePresentations(r);
    });
    makeNotLoading();
  }

  deleteSelectedPresentation(Presentation e) async {
    final response = await deletePresentation(e);
    response.fold((l) => l.handleError(), (r) => getPresentations());
  }

  showDeletePresentationConfirmation(Presentation e) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Presentation'),
        content: Text('Are you sure you want to delete ${e.name} ?'),
        actions: [
          ElevatedButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteSelectedPresentation(e);
              Get.back();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
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

  List<Presentation> searchResult(List<Presentation> presentations) {
    return presentations
        .where((element) => element.name
            .toLowerCase()
            .contains(searchPresentationController.text.toLowerCase()))
        .toList();
  }

  void addModule() {
    moduleVisePresentations.add(
        {"module": moduleVisePresentations.length + 1, "presentations": []});
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'add_presentation_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  AddNewPresentation addNewPresentation = AddNewPresentation(Get.find());

  // TextEditingController moduleController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  FocusNode tagFocusNode = FocusNode();
  // FocusNode moduleFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  TextEditingController presentationNameController = TextEditingController();
  List<String> tags = [];

  // get areasItems => presentationsListingController.areas
  //     .map((e) => DropdownMenuItem<Area>(value: e, child: Text(e.name)))
  //     .toList();

  // Area? selectedArea;
  // int module = 1;

  void addNewTag(String value) {
    if (value.isEmpty) {
      FocusScope.of(Get.context!).nextFocus();
      return;
    }
    tags.add(value);
    tagController.clear();
    notifyListeners();
    tagFocusNode.requestFocus();
  }

  void addEditPresentation(
      AddNewPresentationParams addNewPresentationParams) async {
    if (!validate()) return;
    final response = await addNewPresentation(addNewPresentationParams);
    popDialog();
    response.fold((l) => l.handleError(), (r) {
      getPresentations();
    });
  }

  void dropPresentation(
      AddNewPresentationParams addNewPresentationParams) async {
    final response = await addNewPresentation(addNewPresentationParams);
    popDialog();
    response.fold((l) => l.handleError(), (r) {
      getPresentations();
    });
  }

  removeTag(String e) {
    tags.remove(e);
    notifyListeners();
  }

  String? nameValidator(String? value) {
    return value!.isEmpty ? 'Please enter a presentation name' : null;
  }

  String? moduleValidate(String? value) {
    return value!.isEmpty ? 'Please enter a module number' : null;
  }

  void clearFields() {
    presentationNameController.clear();
    tagController.clear();
    // moduleController.clear();
    selectedArea = null;
  }

  showAddEditPresentaion({int? module, Presentation? presentation}) {
    // if (selectedArea == null) return;
    if (presentation == null) {
      presentationNameController.clear();
      tags.clear();
    } else {
      presentationNameController.text = presentation.name;
      tags = presentation.tags;
    }
    Get.dialog(AlertDialog(
        title: Text(presentation == null
            ? "Add New Presentation"
            : "Edit Presentation"),
        content: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                focusNode: nameFocusNode,
                controller: presentationNameController,
                decoration: const InputDecoration(
                  labelText: "Presentation Name",
                ),
                validator: nameValidator,
              ),
              defaultSpacer,
              AnimatedBuilder(
                  animation: this,
                  builder: (context, child) {
                    return Wrap(
                      children: tags
                          .map((e) => InputChip(
                                label: Text(e),
                                onDeleted: () => removeTag(e),
                              ))
                          .toList(),
                    );
                  }),
              TextFormField(
                focusNode: tagFocusNode,
                decoration: const InputDecoration(
                  labelText: "Tag",
                ),
                controller: tagController,
                onFieldSubmitted: addNewTag,
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () => addEditPresentation(AddNewPresentationParams(
                  id: presentation?.id,
                  area: selectedArea?.id,
                  name: presentationNameController.text,
                  module: presentation == null ? module! : presentation.module,
                  tags: tags)),
              child: Text(presentation == null ? "Add" : "Save")),
        ]));
  }
}
