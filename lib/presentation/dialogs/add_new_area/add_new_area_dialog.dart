import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/dialogs/add_new_area/add_new_area_dialog_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class AddNewAreaDialog extends StatelessWidget {
  const AddNewAreaDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddNewAreaController addNewAreaController = AddNewAreaController();
    return AnimatedBuilder(
        animation: addNewAreaController,
        builder: (context, child) {
          return AlertDialog(
              title: const Text("Add New Area"),
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
                      onFieldSubmitted: (val) => addNewAreaController.addArea(),
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
                    onPressed: addNewAreaController.addArea,
                    child: const Text("Add")),
              ]);
        });
  }
}
