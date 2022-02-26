import 'package:flutter/foundation.dart';

consolelog(dynamic data) {
  if (kDebugMode) {
    print(data.toString());
  } 
}
