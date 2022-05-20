import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/course_list_response.dart';
import 'package:folldy_admin/presentation/screens/subjects_listing/subjects_listing.dart';

class SemesterTab extends StatelessWidget {
  const SemesterTab({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course? course;

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      return Container();
    }
    return DefaultTabController(
        length: course!.semesters,
        child: Column(
          children: [
            TabBar(
                tabs: List.generate(
                    course!.semesters,
                    (index) => Tab(
                          text: "Semester ${index + 1}",
                        ))),
            Expanded(child: Builder(builder: (context) {
              final semesterController = DefaultTabController.of(context)!;
              return AnimatedBuilder(
                  animation: semesterController,
                  builder: (context, child) {
                    return SubjectsListing(
                      course: course!,
                      semester: semesterController.index + 1,
                    );
                  });
            })),
          ],
        ));
  }
}
