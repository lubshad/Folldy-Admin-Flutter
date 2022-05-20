import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/courses_listing/courses_listing.dart';
import 'package:folldy_admin/presentation/screens/universities_listing/university_listing_controller.dart';
import 'package:get/get.dart';

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
    
    UniversityListingController universityListingController = Get.find();
    universityListingController.getData();

    return AnimatedBuilder(
      animation: universityListingController,
      builder: (BuildContext context, Widget? child) {
        return Row(
          children: [
            Drawer(
              child: Column(
                children: [
                  Container(
                    height: defaultPaddingLarge * 2,
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Universities",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: universityListingController
                                .showAddUniversityDialog,
                            icon: const Icon(Icons.add))
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(children: [
                      ...universityListingController.universities
                          .map((university) => ListTile(
                            key: Key(university.id.toString()),
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
