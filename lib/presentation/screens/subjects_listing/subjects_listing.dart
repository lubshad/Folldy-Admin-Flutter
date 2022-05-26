import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/home_screen/home_controller.dart';
import 'package:folldy_admin/presentation/screens/subjects_listing/subjects_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:folldy_utils/data/models/course_list_response.dart';
import 'package:get/get.dart';

class SubjectsListing extends StatelessWidget {
  const SubjectsListing({
    Key? key,
    required this.course,
    required this.semester,
  }) : super(key: key);

  final Course course;
  final int semester;

  @override
  Widget build(BuildContext context) {
    SubjectListingController subjectListingController = Get.find();
    subjectListingController.course = course;
    subjectListingController.semester = semester;
    subjectListingController.searchSubjectController.clear();
    subjectListingController.getData();
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
            animation: Listenable.merge([subjectListingController]),
            builder: (BuildContext context, Widget? child) {
              final semesterSubjects = subjectListingController.subjects
                  .where((element) => element.semester == semester)
                  .toList();
              return ListView.builder(
                  itemCount: semesterSubjects.length,
                  itemBuilder: (BuildContext context, int index) {
                    final subject = semesterSubjects[index];
                    return ListTile(
                      onTap: () {
                        Get.find<SubjectListingController>().selectedSubject =
                            subject;
                        Get.find<HomeController>()
                            .selectItem(DrawerItem.subjects);
                      },
                      key: Key(subject.id.toString()),
                      // onTap: () => Get.toNamed(AppRoute.subjectDetails,
                      //     arguments: subject),
                      title: Text(subject.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => subjectListingController
                                .showEditSubjectDialog(subject),
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => subjectListingController
                                .showDeleteSubjectConfirmation(subject),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
