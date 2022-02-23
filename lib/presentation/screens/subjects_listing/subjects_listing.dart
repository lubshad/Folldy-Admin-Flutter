import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/subjects_listing/subjects_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/app_theme.dart';

class SubjectsListing extends StatelessWidget {
  const SubjectsListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SubjectListingController subjectListingController =
        SubjectListingController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: subjectListingController.showAddSubjectDialog,
                label: const Text("Add New Subject"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: subjectListingController,
            builder: (BuildContext context, Widget? child) {
              return ListView(
                  children: subjectListingController.subjects
                      .map((subject) => ListTile(
                            title: Text(subject.name),
                          ))
                      .toList());
            },
          ),
        ),
      ],
    );
  }
}
