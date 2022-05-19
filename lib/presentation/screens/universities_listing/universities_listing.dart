import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/courses_listing/courses_listing.dart';
import 'package:folldy_admin/presentation/screens/universities_listing/university_listing_controller.dart';

import '../../theme/theme.dart';

enum PopupOptions {
  edit,
  delete,
}

extension PopupOptionsExtension on PopupOptions {
  String get title {
    switch (this) {
      case PopupOptions.edit:
        return 'Edit';
      case PopupOptions.delete:
        return 'Delete';
      default:
        return '';
    }
  }
}

class UniversitiesListing extends StatelessWidget {
  const UniversitiesListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UniversityListingController universityListingController =
        UniversityListingController();
    universityListingController.getData();

    return AnimatedBuilder(
      animation: universityListingController,
      builder: (BuildContext context, Widget? child) {
        return Row(
          children: [
            Drawer(
              elevation: 0,
              child: Column(
                children: [
                  const DrawerHeader(
                      child: Center(child: Text("Universities"))),
                  Expanded(
                    child: ListView(children: [
                      ...universityListingController.universities
                          .map((university) => ListTile(
                                selected: university.id ==
                                    universityListingController
                                        .selectedUniversity?.id,
                                onTap: () => universityListingController
                                    .selectUniversity(university),
                                title: Text(university.name),
                                trailing: PopupMenuButton<PopupOptions>(
                                    itemBuilder: ((context) => PopupOptions
                                        .values
                                        .map((e) => PopupMenuItem(
                                            value: e, child: Text(e.title)))
                                        .toList()),
                                    onSelected: (popupOption) {
                                      switch (popupOption) {
                                        case PopupOptions.edit:
                                          universityListingController
                                              .showEditUniversityDialog(
                                                  university);
                                          break;
                                        case PopupOptions.delete:
                                          universityListingController
                                              .showDeleteUniversityConfirmation(
                                                  university);

                                          break;
                                      }
                                    }),
                              ))
                          .toList(),
                      Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: TextButton.icon(
                          onPressed: universityListingController
                              .showAddUniversityDialog,
                          label: const Text("Add New University"),
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            const VerticalDivider(),
            Expanded(
                child: CorusesListing(
                    university:
                        universityListingController.selectedUniversity)),
          ],
        );
      },
    );
  }
}
