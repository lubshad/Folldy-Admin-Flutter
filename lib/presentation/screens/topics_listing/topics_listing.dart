import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/theme/app_theme.dart';
import 'package:get/get.dart';

class TopicsListing extends StatelessWidget {
  const TopicsListing({
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
                onPressed: showAddTopicDialog,
                label: const Text("Add New Topic"),
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
                      title: Text("Topic $index"),
                    )),
          ),
        ),
      ],
    );
  }

  void showAddTopicDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
          title: const Text("Add New Topic"),
          content: const TextField(
            decoration: InputDecoration(
              labelText: "Topic Name",
            ),
          ),
          actions: [
            ElevatedButton(onPressed: () {}, child: const Text("Add")),
          ]),
    );
  }
}
