import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/universities_listing/university_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/app_theme.dart';

class UniversitiesListing extends StatelessWidget {
  const UniversitiesListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UniversityListingController universityListingController =
        UniversityListingController();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: universityListingController.showAddUniversityDialog,
                label: const Text("Add New University"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: universityListingController,
            builder: (BuildContext context, Widget? child) {
              return ListView(
                children: universityListingController.universities
                    .map((e) => ListTile(
                          title: Row(
                            children: [
                              Text(e.name),
                              const Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () => universityListingController
                                        .deleteSelectedUniversity(e),
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
