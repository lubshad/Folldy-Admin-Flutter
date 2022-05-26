import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:folldy_utils/data/models/institution_list_response.dart';

import 'faculties_listing_controller.dart';

class FacultyListing extends StatelessWidget {
  const FacultyListing({
    Key? key,
    this.institution,
  }) : super(key: key);

  final Institution? institution;

  @override
  Widget build(BuildContext context) {
    if (institution == null) {
      return Container();
    }
    FacultyListingController facultylistingController = Get.find();
    facultylistingController.selectedInstitution = institution;
    facultylistingController.getFacultys();
    return Column(
      children: [
        Container(
          height: defaultPaddingLarge * 2,
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                institution?.name ?? "",
                style: Theme.of(context).textTheme.headline6,
              ),
              TextButton.icon(
                onPressed: facultylistingController.showAddEditFacultyDialog,
                label: const Text("Add New Faculty"),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: AnimatedBuilder(
            animation: facultylistingController,
            builder: (BuildContext context, Widget? child) {
              return ListView.builder(
                  itemCount: facultylistingController.faculties.length,
                  itemBuilder: ((context, index) => Builder(builder: (context) {
                        final faculty =
                            facultylistingController.faculties[index];
                        return ListTile(
                          title: Text(faculty.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => facultylistingController
                                    .showAddEditFacultyDialog(faculty: faculty),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => facultylistingController
                                    .showDeleteConfirmationDialog(faculty),
                              ),
                            ],
                          ),
                        );
                      })));
            },
          ),
        ),
      ],
    );
  }
}
