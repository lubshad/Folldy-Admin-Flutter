import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folldy_admin/data/models/area_list_response.dart';
import 'package:folldy_admin/presentation/dialogs/add_presentation_dialog/add_presentation_dialog_controller.dart';
import 'package:folldy_admin/presentation/screens/presentations_listing/presentation_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class AddPresentationDialog extends StatelessWidget {
  const AddPresentationDialog(
      {Key? key, required this.presentationsListingController})
      : super(key: key);

  final PresentationsListingController presentationsListingController;

  @override
  Widget build(BuildContext context) {
    AddPresentationDialogController addPresentationDialogController =
        AddPresentationDialogController(presentationsListingController);
    addPresentationDialogController.nameFocusNode.requestFocus();
    return AnimatedBuilder(
        animation: addPresentationDialogController,
        builder: (context, child) {
          return AlertDialog(
              title: const Text("Add New Presentation"),
              content: Form(
                key: addPresentationDialogController.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      // autofocus: true,
                      focusNode: addPresentationDialogController.nameFocusNode,
                      controller: addPresentationDialogController
                          .presentationNameController,
                      decoration: const InputDecoration(
                        labelText: "Presentation Name",
                      ),
                      validator: addPresentationDialogController.nameValidator,
                    ),
                    Autocomplete<Area>(
                      fieldViewBuilder:
                          addPresentationDialogController.areaFieldViewBuilder,
                      displayStringForOption: (Area area) => area.name,
                      optionsBuilder:
                          addPresentationDialogController.areaOptionsBuilder,
                      onSelected:
                          addPresentationDialogController.changeSelectedArea,
                    ),
                    TextFormField(
                      focusNode:
                          addPresentationDialogController.moduleFocusNode,
                      decoration: const InputDecoration(
                        labelText: "Module",
                      ),
                      controller:
                          addPresentationDialogController.moduleController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(2),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: addPresentationDialogController.moduleValidate,
                    ),
                    defaultSpacer,
                    Wrap(
                      children: addPresentationDialogController.tags
                          .map((e) => InputChip(
                                label: Text(e),
                                onDeleted: () => addPresentationDialogController
                                    .removeTag(e),
                              ))
                          .toList(),
                    ),
                    TextFormField(
                      focusNode: addPresentationDialogController.tagFocusNode,
                      decoration: const InputDecoration(
                        labelText: "Tag",
                      ),
                      controller: addPresentationDialogController.tagController,
                      onFieldSubmitted:
                          addPresentationDialogController.addNewTag,
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: addPresentationDialogController.addPresentation,
                    child: const Text("Add")),
              ]);
        });
  }
}
