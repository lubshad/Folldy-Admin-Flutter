import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/chapter_list_response.dart';
import 'package:folldy_admin/presentation/screens/home_screen/home_screen.dart';

import 'screens/chapter_details/chapter_details.dart';

class AppRoute {
  static const String initial = '/';
  static const String chapterDetails = '/chapter_details';

  // onGenerateRoute
  static Route onGenerateRoute(RouteSettings settings) {
    final routeName = getRouteName(settings);
    final arguments = getArguments(settings);
    switch (routeName) {
      case initial:
        return MaterialPageRoute(builder: (context) => const Home());
      case chapterDetails:
        return MaterialPageRoute(
            builder: (context) =>
                ChapterDetails(chapter: arguments as Chapter));
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }

  static List<Route> onGenerateInitialRoute(String initialRoute) {
    // final arguments = Uri.parse(initialRoute).queryParameters;
    // for (var element in availableFonts) {
    //   logger.info(element);
    // }
    return [
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    ];
  }
}
