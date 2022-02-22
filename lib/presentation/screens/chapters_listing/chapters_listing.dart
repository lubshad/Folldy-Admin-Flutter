import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/theme/app_theme.dart';
import 'package:get/get.dart';

class ChaptersListing extends StatelessWidget {
  const ChaptersListing({
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
                onPressed: showAddChapterDialog,
                label: const Text("Add New Chapter"),
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
                      title: Text("Chapter $index"),
                    )),
          ),
        ),
      ],
    );
  }

  void showAddChapterDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
          title: const Text("Add New Chapter"),
          content: const TextField(
            decoration: InputDecoration(
              labelText: "Chapter Name",
            ),
          ),
          actions: [
            ElevatedButton(onPressed: () {}, child: const Text("Add")),
          ]),
    );
  }
}
