import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/theme/app_theme.dart';
import 'package:get/get.dart';

class SubjectsListing extends StatelessWidget {
  const SubjectsListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: showAddSubjectDialog,
                label: const Text("Add New Subject"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView(
            children: List.generate(
                5,
                (index) => ListTile(
                      title: Text("Subject $index"),
                    )),
          ),
        ),
      ],
    );
  }

  void showAddSubjectDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
          title: const Text("Add New Subject"),
          content: const TextField(
            decoration: InputDecoration(
              labelText: "Subject Name",
            ),
          ),
          actions: [
            ElevatedButton(onPressed: () {}, child: const Text("Add")),
          ]),
    );
  }
}
