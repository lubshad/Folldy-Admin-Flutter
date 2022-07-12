import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/android_settings/android_settings_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class AndroidSettings extends StatelessWidget {
  const AndroidSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AndroidSettingsController androidSettingsController =
        AndroidSettingsController();
    androidSettingsController.getData();
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Form(
        key: androidSettingsController.formKey,
        child: Column(
          children: [
            Text(
              "ANDROID",
              style: Theme.of(context).textTheme.headline6,
            ),
            defaultSpacerLarge,
            Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft, child: Text("Teacher")),
                const Divider(),
                TextField(
                  controller:
                      androidSettingsController.currentVersionTeacherController,
                  decoration:
                      const InputDecoration(label: Text("Current Version")),
                ),
                TextField(
                  controller:
                      androidSettingsController.minimumVersionTeacherController,
                  decoration:
                      const InputDecoration(label: Text("Minimum Version")),
                ),
                TextField(
                  controller: androidSettingsController.appUrlTeacherController,
                  decoration: const InputDecoration(label: Text("App Url")),
                ),
                TextField(
                  controller:
                      androidSettingsController.updateMessageTeacherController,
                  decoration:
                      const InputDecoration(label: Text("Update Message")),
                ),
              ],
            ),
            defaultSpacer,
            ElevatedButton(
                onPressed: androidSettingsController.update,
                child: const Text("Update"))
          ],
        ),
      ),
    );
  }
}
