import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/chapters_listing/chapters_listing.dart';
import 'package:folldy_admin/presentation/screens/subject_presentation_listing/subject_presentation_listing.dart';
import 'package:folldy_utils/data/models/subject_list_response.dart';

class SubjectDetailsNew extends StatelessWidget {
  const SubjectDetailsNew({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(subject.name),
          bottom: const TabBar(tabs: [
            Tab(text: 'Presentations'),
            Tab(text: 'Chapters'),
          ]),
        ),
        body: TabBarView(children: [
          SubjectPresentationListing(subject: subject),
          ChaptersListing(
            subject: subject,
          ),
        ]),
      ),
    );
  }
}
