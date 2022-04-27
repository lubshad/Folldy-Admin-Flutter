import 'dart:async';

import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/domain/usecase/add_new_presentation.dart';
import 'package:folldy_admin/presentation/screens/presentations_listing/presentation_listing_controller.dart';
import 'package:get/get.dart';

class AddPresentationDialogController extends ChangeNotifier {
  final PresentationsListingController presentationsListingController;
  AddPresentationDialogController(this.presentationsListingController);

  final formKey = GlobalKey<FormState>(debugLabel: 'add_presentation_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  AddNewPresentation addNewPresentation = AddNewPresentation(Get.find());

  TextEditingController moduleController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  FocusNode tagFocusNode = FocusNode();
  FocusNode moduleFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  TextEditingController presentationNameController = TextEditingController();
  List<String> tags = [];

  get areasItems => presentationsListingController.areas
      .map((e) => DropdownMenuItem<Area>(value: e, child: Text(e.name)))
      .toList();

  Area? selectedArea;

  FutureOr<Iterable<Area>> areaOptionsBuilder(
      TextEditingValue textEditingValue) {
    if (textEditingValue.text == '') {
      return const Iterable<Area>.empty();
    }
    return presentationsListingController.areas.where((Area option) {
      return option.name
          .toLowerCase()
          .contains(textEditingValue.text.toLowerCase());
    });
  }

  Widget areaFieldViewBuilder(
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted) {
    return TextFormField(
      validator: (value) => value!.isEmpty
          ? 'Please select an area'
          : selectedArea?.name != value
              ? 'Please select a valid area'
              : null,
      controller: textEditingController,
      focusNode: focusNode,
      onFieldSubmitted: (_) => onFieldSubmitted(),
      decoration: const InputDecoration(
        labelText: "Area",
      ),
    );
  }

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

  void changeSelectedArea(Area? value) {
    selectedArea = value;
    notifyListeners();
    moduleFocusNode.requestFocus();
  }

  void addPresentation() async {
    if (!validate()) return;
    final response = await addNewPresentation(Presentation(
        area: selectedArea!.id,
        name: presentationNameController.text,
        id: 1,
        module: int.parse(moduleController.text),
        tags: tags));
    if (Get.isDialogOpen == true) Get.back();
    // clearFields();
    response.fold((l) => l.handleError(), (r) {
      presentationsListingController.getData();
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
    moduleController.clear();
    selectedArea = null;
  }
}
