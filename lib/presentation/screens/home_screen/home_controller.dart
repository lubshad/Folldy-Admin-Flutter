import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/course_listing_with_drawer/course_listing_with_drawer.dart';
import 'package:folldy_admin/presentation/screens/institutions_listing/institutions_listing.dart';
import 'package:folldy_admin/presentation/screens/subject_listing_with_drawer/subject_listing_with_drawer.dart';

import '../app_settings/app_settings.dart';
import '../area_vise_presentation_listing/area_vise_presentation_listing.dart';
import '../universities_listing/universities_listing.dart';

class HomeController extends ChangeNotifier {
  DrawerItem selectedItem = DrawerItem.appSettings;

  void selectItem(DrawerItem item) {
    selectedItem = item;
    notifyListeners();
  }
}

enum DrawerItem {
  dashboard,
  universities,
  courses,
  subjects,
  // chapters,
  // areas,
  presentations,
  institutions,
  appSettings,
  // teachers,
  // topics,
}

extension DrawerItemExtension on DrawerItem {
  Widget get body {
    switch (this) {
      case DrawerItem.dashboard:
        return const Center(
          child: Text("Dashboard"),
        );
      case DrawerItem.universities:
        return const UniversitiesListing();
      case DrawerItem.institutions:
        return const InstitutionsListing();
      case DrawerItem.courses:
        return const CourseListingWithDrawer();
      case DrawerItem.subjects:
        return const SubjectListingWithDrawer();
      // case DrawerItem.chapters:
      //   return const ChaptersListing();
      // case DrawerItem.topics:
      //   return const TopicsListing();
      // case DrawerItem.teachers:
      //   return const TeachersListing();
      // case DrawerItem.areas:
      //   return const AreasListing();
      case DrawerItem.presentations:
        return const AreaVisePresentationListing();
      case DrawerItem.appSettings:
        return const AppSettings();
    }
  }

  String get text {
    switch (this) {
      case DrawerItem.dashboard:
        return "Dashboard";
      case DrawerItem.universities:
        return "Universities";
      case DrawerItem.institutions:
        return "Institutions";
      case DrawerItem.courses:
        return "Courses";
      case DrawerItem.subjects:
        return "Subjects";
      // case DrawerItem.chapters:
      //   return "Chapters";
      // case DrawerItem.topics:
      //   return "Topics";
      // case DrawerItem.teachers:
      //   return "Teachers";
      // case DrawerItem.areas:
      //   return "Areas";
      case DrawerItem.presentations:
        return "Presentations";
      case DrawerItem.appSettings:
        return "App Settings";
    }
  }

  Widget get icon {
    switch (this) {
      case DrawerItem.dashboard:
        return const Icon(Icons.dashboard);
      case DrawerItem.universities:
        return const Icon(Icons.school);
      case DrawerItem.institutions:
        return const Icon(Icons.business);
      case DrawerItem.courses:
        return const Icon(Icons.book);
      case DrawerItem.subjects:
        return const Icon(Icons.subject);
      // case DrawerItem.chapters:
      //   return const Icon(Icons.library_books);
      // case DrawerItem.topics:
      //   return const Icon(Icons.library_books);
      // case DrawerItem.teachers:
      //   return const Icon(Icons.person);
      // case DrawerItem.areas:
      // return const Icon(Icons.location_city);
      case DrawerItem.presentations:
        return const Icon(Icons.present_to_all);
      case DrawerItem.appSettings:
        return const Icon(CupertinoIcons.settings);
    }
  }
}
