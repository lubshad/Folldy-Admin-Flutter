import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/domain/usecase/add_new_institution.dart';
import 'package:folldy_admin/domain/usecase/delete_institution.dart';
import 'package:folldy_admin/domain/usecase/get_all_institutions.dart';
import 'package:folldy_admin/presentation/screens/universities_listing/universities_listing.dart';
import 'package:folldy_admin/utils/extensions.dart';

import '../../../data/models/institution_list_response.dart';

class InstitutionListingController extends ChangeNotifier {
  GetAllInstitutions getAllInstitutions = GetAllInstitutions(Get.find());
  // GetAllUniversitys getAllUniversitys = GetAllUniversitys(Get.find());
  AddNewInstitution addNewInstitution = AddNewInstitution(Get.find());
  DeleteInstitution deleteInstitution = DeleteInstitution(Get.find());

  TextEditingController institutionNameController = TextEditingController();
  TextEditingController searchInstitutionController = TextEditingController();
  List<Institution> institutions = [];
  // List<University> universities = [];

  // University? selectedUniversity;
  AppError? appError;
  bool isLoading = true;

  // get universitiesItems => universities
  //     .map((e) => DropdownMenuItem<University>(value: e, child: Text(e.name)))
  //     .toList();

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

  getInstitutions() async {
    final response = await getAllInstitutions(NoParams());
    response.fold((l) => l.handleError(), (r) => institutions = r);
    notifyListeners();
  }

  final formKey = GlobalKey<FormState>(debugLabel: 'institution_form_key');
  bool validate() {
    bool valid = false;
    if (formKey.currentState!.validate()) {
      valid = true;
    }
    return valid;
  }

  addEditInstitutionDialog({Institution? institution}) {
    if (institution == null) {
      institutionNameController.clear();
    } else {
      institutionNameController.text = institution.name;
    }
    Get.dialog(AlertDialog(
        title: Text(
            institution == null ? "Add New institution" : "Edit Institution"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onFieldSubmitted: (value) =>
                    addInstitution(institution: institution),
                controller: institutionNameController,
                decoration: const InputDecoration(
                  labelText: "institution Name",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter institution name';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () => addInstitution(institution: institution),
              child: Text(institution == null ? "Add" : "Save")),
        ]));
  }

  void addInstitution({Institution? institution}) async {
    if (!validate()) return;
    final response = await addNewInstitution(AddInstitutionParams(
      id: institution?.id,
      name: institutionNameController.text,
    ));

    response.fold((l) => l.handleError(), (r) {
      popDialog();
      getInstitutions();
    });
  }

  deleteSelectedInstitution(Institution e) async {
    await deleteInstitution(e);
    selectedInstitution?.id == e.id ? selectedInstitution = null : null;
    popDialog();
    getInstitutions();
  }

  showDeleteConfirmation(Institution e) {
    Get.dialog(AlertDialog(
      title: const Text("Delete Institution"),
      content: Text("Are you sure you want to delete ${e.name}?"),
      actions: [
        ElevatedButton(
          onPressed: () => popDialog(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => deleteSelectedInstitution(e),
          child: const Text("Delete"),
        ),
      ],
    ));
  }

  void onOptionSelected(PopupOptions value, Institution institution) {
    switch (value) {
      case PopupOptions.edit:
        addEditInstitutionDialog(institution: institution);
        break;
      case PopupOptions.delete:
        showDeleteConfirmation(institution);
        break;
    }
  }

  Institution? selectedInstitution;
  selectInstitution(Institution institution) {
    selectedInstitution = institution;
    notifyListeners();
  }
}
