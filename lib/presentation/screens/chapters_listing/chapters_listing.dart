import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/chapters_listing/chapter_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class ChaptersListing extends StatelessWidget {
  const ChaptersListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChapterListingController chapterListingController =
        ChapterListingController();
    chapterListingController.getData();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: chapterListingController.showAddChapterDialog,
                label: const Text("Add New Chapter"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: chapterListingController,
            builder: (BuildContext context, Widget? child) {
              return ListView.builder(
                itemCount: chapterListingController.chapters.length,
                itemBuilder: (BuildContext context, int index) {
                  final chapter = chapterListingController.chapters[index];
                  return ListTile(
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
