import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/theme/app_theme.dart';
import 'package:get/get.dart';

class CorusesListing extends StatelessWidget {
  const CorusesListing({
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
                onPressed: showAddCourseDialog,
                label: const Text("Add New course"),
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
                      title: Text("course $index"),
                    )),
          ),
        ),
      ],
    );
  }

  void showAddCourseDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
          title: const Text("Add New course"),
          content: const TextField(
            decoration: InputDecoration(
              labelText: "course Name",
            ),
          ),
          actions: [
            ElevatedButton(onPressed: () {}, child: const Text("Add")),
          ]),
    );
  }
}
