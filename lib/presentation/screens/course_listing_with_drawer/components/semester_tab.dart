import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/subjects_listing/subjects_listing.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:folldy_utils/data/models/course_list_response.dart';

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
    return Column(
      children: [
        Container(
          height: defaultPaddingLarge * 2,
          padding: const EdgeInsets.all(defaultPadding),
          alignment: Alignment.centerLeft,
          child: RichText(
            text: TextSpan(
                text: course!.name + ' ',
                style: Theme.of(context).textTheme.headline6,
                children: [
                  TextSpan(
                      text: "(${course!.university.name})",
                      style: Theme.of(context).textTheme.subtitle1)
                ]),
          ),
        ),
        const Divider(),
        Expanded(
          child: DefaultTabController(
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
                    final semesterController =
                        DefaultTabController.of(context)!;
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
              )),
        ),
      ],
    );
  }
}
