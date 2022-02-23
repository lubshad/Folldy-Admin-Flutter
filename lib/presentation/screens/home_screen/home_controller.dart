import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/chapters_listing/chapters_listing.dart';
import 'package:folldy_admin/presentation/screens/courses_listing/courses_listing.dart';
import 'package:folldy_admin/presentation/screens/institutions_listing/institutions_listing.dart';
import 'package:folldy_admin/presentation/screens/subjects_listing/subjects_listing.dart';
import 'package:folldy_admin/presentation/screens/topics_listing/topics_listing.dart';

import '../universities_listing/universities_listing.dart';

class HomeController extends ChangeNotifier {
  DrawerItem selectedItem = drawerItems[6];

  void selectItem(DrawerItem item) {
    selectedItem = item;
    notifyListeners();
  }
}

final drawerItems = [
  DrawerItem(
    text: "Dashboard",
    icon: Icons.dashboard,
    body: const Center(
      child: Text("Dashboard"),
    ),
  ),
  DrawerItem(
    text: "Universities",
    icon: Icons.school,
    body: const UniversitiesListing(),
  ),
  DrawerItem(
    text: "Institutions",
    icon: Icons.business,
    body: const Center(
      child: InstitutionsListing(),
    ),
  ),
  DrawerItem(
    text: "Courses",
    icon: Icons.book,
    body: const Center(
      child: CorusesListing(),
    ),
  ),
  DrawerItem(
    text: "Subjects",
    icon: Icons.subject,
    body: const Center(
      child: SubjectsListing(),
    ),
  ),
  DrawerItem(
    text: "Chapters",
    icon: Icons.library_books,
    body: const Center(
      child: ChaptersListing(),
    ),
  ),
  DrawerItem(
    text: "Topics",
    icon: Icons.library_books,
    body: const Center(
      child: TopicsListing(),
    ),
  ),
];

class DrawerItem {
  final String text;
  final IconData icon;
  final Widget body;

  DrawerItem({required this.text, required this.icon, required this.body});
}
