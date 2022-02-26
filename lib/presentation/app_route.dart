import 'package:flutter/material.dart';

import 'screens/topic_details_screen/topic_details_screen.dart';

class AppRoute {
  static const topicDetailsScreen = '/topicDetailsScreen';

  static Map<String, WidgetBuilder> get  routes => {
    topicDetailsScreen: (context) => const TopicDetailsScreen(),
  };

}




