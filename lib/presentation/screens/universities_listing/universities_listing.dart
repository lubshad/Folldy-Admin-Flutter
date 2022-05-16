import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/universities_listing/university_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class UniversitiesListing extends StatelessWidget {
  const UniversitiesListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UniversityListingController universityListingController =
        UniversityListingController();
    universityListingController.getData();

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
              return ListView.builder(
                itemCount: universityListingController.universities.length,
                itemBuilder: (BuildContext context, int index) {
                  final university =
                      universityListingController.universities[index];
                  return ListTile(
                    title: Row(
                      children: [
                        Text(university.name),
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => universityListingController.showEditUniversityDialog(university),
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => universityListingController
                                  .showDeleteUniversityConfirmation(university),
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
