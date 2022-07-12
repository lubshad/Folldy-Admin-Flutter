import 'package:flutter/material.dart';

import '../android_settings/android_settings.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: AndroidSettings()),
        VerticalDivider(),
        Expanded(child: IOSsettings()),
      ],
    );
  }
}

class IOSsettings extends StatelessWidget {
  const IOSsettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("IOS");
  }
}
