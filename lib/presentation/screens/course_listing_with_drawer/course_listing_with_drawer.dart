import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/courses_listing/course_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

import 'components/semester_tab.dart';

class CourseListingWithDrawer extends StatelessWidget {
  const CourseListingWithDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CourseListingController courseListingController = Get.find();
    // courseListingController.university = null;
    courseListingController.getCourses();
    courseListingController.searchCourseController.addListener(() {
      courseListingController.getCourses();
    });
    return Row(
      children: [
        Drawer(
          child: Column(
            children: [
              Container(
                height: defaultPaddingLarge * 2,
                padding: const EdgeInsets.all(defaultPadding),
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: 'Search course',
                      suffixIcon: Icon(Icons.search),
                      border: InputBorder.none),
                  controller: courseListingController.searchCourseController,
                ),
              ),
              const Divider(),
              Expanded(
                  child: AnimatedBuilder(
                      animation: courseListingController,
                      builder: (context, child) {
                        return ListView.builder(
                            itemCount: courseListingController.courses.length,
                            itemBuilder: ((context, index) {
                              final course =
                                  courseListingController.courses[index];
                              return ListTile(
                                key: Key(course.id.toString()),
                                onTap: () => courseListingController
                                    .selectCourse(course),
                                selected: courseListingController
                                        .selectedCourse?.id ==
                                    course.id,
                                title: Text(course.name),
                                subtitle: Text(course.university.name),
                              );
                            }));
                      }))
            ],
          ),
        ),
        const VerticalDivider(),
        Expanded(
            child: AnimatedBuilder(
                animation: courseListingController,
                builder: (context, child) {
                  return SemesterTab(
                      course: courseListingController.selectedCourse);
                }))
      ],
    );
  }
}
