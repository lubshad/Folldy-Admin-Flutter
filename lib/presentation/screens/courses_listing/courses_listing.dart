import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/courses_listing/course_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class CorusesListing extends StatelessWidget {
  const CorusesListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CourseListingController courseListingController = CourseListingController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: courseListingController.showAddCourseDialog,
                label: const Text("Add New course"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: courseListingController,
            builder: (BuildContext context, Widget? child) {
              return ListView(
                children: courseListingController.courses
                    .map((e) => ListTile(
                          title: Text(e.name),
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
