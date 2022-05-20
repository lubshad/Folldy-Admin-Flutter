import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/presentation/app_route.dart';
import 'package:folldy_admin/presentation/screens/chapters_listing/chapter_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:get/get.dart';

class ChaptersListing extends StatelessWidget {
  const ChaptersListing({
    Key? key,
    required this.subject,
  }) : super(key: key);

  final Subject? subject;

  @override
  Widget build(BuildContext context) {
    if (subject == null) {
      return Container();
    }
    ChapterListingController chapterListingController = Get.find();
    chapterListingController.init(subject!);
    return Column(
      children: [
        Container(
          height: defaultPaddingLarge * 2,
          padding: const EdgeInsets.all(defaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject!.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              TextButton.icon(
                onPressed: chapterListingController.showAddChapterDialog,
                label: const Text("Add New Chapter"),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: AnimatedBuilder(
            animation: chapterListingController,
            builder: (BuildContext context, Widget? child) {
              return ListView.builder(
                itemCount: chapterListingController.chapters.length,
                itemBuilder: (BuildContext context, int index) {
                  final chapter = chapterListingController.chapters[index];
                  return ListTile(
                      onTap: () => Get.toNamed(AppRoute.chapterDetails,
                          arguments: chapter),
                      title: Text(chapter.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () => chapterListingController
                                  .showEditChapterDialog(chapter),
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () => chapterListingController
                                  .showDeleteChapterConfirmationDialog(chapter),
                              icon: const Icon(Icons.delete)),
                        ],
                      ));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
