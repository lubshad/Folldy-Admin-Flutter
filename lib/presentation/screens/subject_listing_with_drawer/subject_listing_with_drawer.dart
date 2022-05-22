import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/chapters_listing/chapters_listing.dart';
import 'package:folldy_admin/presentation/screens/subjects_listing/subjects_listing_controller.dart';

import '../../theme/theme.dart';

class SubjectListingWithDrawer extends StatelessWidget {
  const SubjectListingWithDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SubjectListingController subjectListingController = Get.find();
    subjectListingController.course = null;
    subjectListingController.getData();
    subjectListingController.searchSubjectController.addListener(() {
      subjectListingController.getData();
    });
    return Row(children: [
      Drawer(
        child: Column(
          children: [
            Container(
              height: defaultPaddingLarge * 2,
              padding: const EdgeInsets.all(defaultPadding),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: 'Search subject',
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none),
                controller: subjectListingController.searchSubjectController,
              ),
            ),
            const Divider(),
            Expanded(
                child: AnimatedBuilder(
                    animation: subjectListingController,
                    builder: (context, child) {
                      return ListView.builder(
                          itemCount: subjectListingController.subjects.length,
                          itemBuilder: ((context, index) {
                            final subject =
                                subjectListingController.subjects[index];
                            return ListTile(
                              key: Key(subject.id.toString()),
                              onTap: () => subjectListingController
                                  .selectSubject(subject),
                              selected: subjectListingController
                                      .selectedSubject?.id ==
                                  subject.id,
                              title: Text(subject.name),
                              subtitle: Text(subject.course.name),
                            );
                          }));
                    }))
          ],
        ),
      ),
      const VerticalDivider(),
      Expanded(
          child: AnimatedBuilder(
              animation: subjectListingController,
              builder: (context, child) {
                return ChaptersListing(
                  subject: subjectListingController.selectedSubject,
                );
              }))
    ]);
  }
}
