import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/teachers_listing%20copy/teachers_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class TeachersListing extends StatelessWidget {
  const TeachersListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TeacherListingController teacherlistingController =
        TeacherListingController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: teacherlistingController.pickFile,
                label: const Text("Add New Teacher"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: teacherlistingController,
            builder: (BuildContext context, Widget? child) {
              return ListView(
                  children: teacherlistingController.teachers
                      .map((e) => ListTile(
                            // onTap: () => Get.toNamed(
                            //     AppRoute.teacherDetailsScreen,
                            //     arguments: e),
                            title: Row(
                              children: [
                                Text(e.name),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () => teacherlistingController
                                        .deleteTeacher(e),
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ))
                      .toList());
            },
          ),
        ),
      ],
    );
  }
}
