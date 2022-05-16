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
    courseListingController.getData();
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
              return ListView.builder(
                itemCount: courseListingController.courses.length,
                itemBuilder: (BuildContext context, int index) {
                  final course = courseListingController.courses[index];
                  return ListTile(
                    title: Text(course.name),
                    // subtitle: Text(course.university.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => courseListingController
                              .showEditCourseDialog(course),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => courseListingController
                              .showDeleteCourseConfirmation(course),
                          icon: const Icon(Icons.delete),
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
