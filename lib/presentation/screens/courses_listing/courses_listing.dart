import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/university_list_response.dart';
import 'package:folldy_admin/presentation/screens/courses_listing/course_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:get/get.dart';

class CorusesListing extends StatelessWidget {
  const CorusesListing({
    Key? key,
    this.university,
  }) : super(key: key);

  final University? university;

  @override
  Widget build(BuildContext context) {
    if (university == null) {
      return Container();
    }
    CourseListingController courseListingController = Get.find();
    courseListingController.university = university;
    courseListingController.getCourses();
    return Column(
      children: [
        Container(
          height: defaultPaddingLarge * 2,
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                university!.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextButton.icon(
                onPressed: courseListingController.showAddCourseDialog,
                label: const Text("Add New course"),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: AnimatedBuilder(
            animation: courseListingController,
            builder: (BuildContext context, Widget? child) {
              return ListView.builder(
                itemCount: courseListingController.courses.length,
                itemBuilder: (BuildContext context, int index) {
                  final course = courseListingController.courses[index];
                  return ListTile(
                    key: Key(course.id.toString()),
                    title: Text(course.name),
                    subtitle: Text(course.university.name),
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
