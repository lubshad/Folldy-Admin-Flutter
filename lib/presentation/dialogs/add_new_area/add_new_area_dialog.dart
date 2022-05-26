import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/dialogs/add_new_area/add_new_area_dialog_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:folldy_utils/data/models/area_list_response.dart';

class AddEditAreaDialog extends StatelessWidget {
  const AddEditAreaDialog({
    Key? key,
    this.area, required this.getAreas,
  }) : super(key: key);

  final Area? area;
  final VoidCallback getAreas;

  @override
  Widget build(BuildContext context) {
    AddEditAreaController addNewAreaController =
        AddEditAreaController(area: area , getAreas: getAreas);
    return AnimatedBuilder(
        animation: addNewAreaController,
        builder: (context, child) {
          return AlertDialog(
              title: Text(area == null ? "Add New Area" : "Edit Area"),
              content: Form(
                key: addNewAreaController.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      autofocus: true,
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return 'Please enter area name';
                        }
                        return null;
                      },
                      controller: addNewAreaController.areaNameController,
                      decoration: const InputDecoration(
                        labelText: "Area Name",
                      ),
                      onFieldSubmitted: (val) =>
                          addNewAreaController.addEditArea(),
                    ),
                    defaultSpacerLarge,
                    Container(
                      height: 200,
                      width: 200,
                      decoration: addNewAreaController.pickedImage == null
                          ? null
                          : BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(
                                      addNewAreaController.pickedImage!.bytes!),
                                  fit: BoxFit.cover)),
                      child: IconButton(
                        icon: Icon(
                          Icons.image_search_rounded,
                          color: addNewAreaController.pickedImage == null
                              ? Colors.black
                              : Colors.white,
                        ),
                        onPressed: addNewAreaController.pickImage,
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () =>
                        addNewAreaController.addEditArea(area: area),
                    child: Text(area == null ? "Add Area" : "Save Area")),
              ]);
        });
  }
}
