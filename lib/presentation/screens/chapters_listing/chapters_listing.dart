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
              return ListView(
                  children: chapterListingController.chapters
                      .map(
                        (chapter) => ListTile(
                          title: Text(chapter.name),
                        ),
                      )
                      .toList());
            },
          ),
        ),
      ],
    );
  }
}
