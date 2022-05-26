import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_utils/data/models/chapter_list_response.dart';
import 'package:folldy_admin/presentation/components/error_message_with_retry.dart';
import 'package:folldy_admin/presentation/screens/chapter_details/chapter_details_controller.dart';
import 'package:folldy_admin/presentation/screens/presentation_selection_listing/presentation_selection_listing.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class ChapterDetails extends StatelessWidget {
  const ChapterDetails({
    Key? key,
    required this.chapter,
  }) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    ChapterDetailsController chapterDetailsController =
        ChapterDetailsController();
    chapterDetailsController.init(chapter);
    return AnimatedBuilder(
        animation: chapterDetailsController,
        child: PresentationSelectionListing(
            addPresentations: (presentations) =>
                chapterDetailsController.addPresntations(presentations)),
        builder: (context, child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(chapter.name),
                actions: [
                  TextButton(
                      onPressed:
                          chapterDetailsController.touglePresentationListing,
                      child: Row(
                        children: [
                          if (!chapterDetailsController.presentaionListing)
                            const Icon(Icons.add),
                          Text(chapterDetailsController.presentaionListing
                              ? "Done"
                              : 'Add Presentation'),
                        ],
                      ))
                ],
              ),
              body: LayoutBuilder(builder: (context, constraints) {
                return Stack(
                  children: [
                    NetworkResource(
                      errorWidget: Builder(builder: (context) {
                        return ErrorMessageWithRetry(
                            error: chapterDetailsController.appError!,
                            retry: chapterDetailsController.retry);
                      }),
                      error: chapterDetailsController.appError,
                      isLoading: chapterDetailsController.isLoading,
                      child: ListView.builder(
                          itemCount:
                              chapterDetailsController.presentations.length,
                          itemBuilder: ((context, index) {
                            final presentation =
                                chapterDetailsController.presentations[index];
                            return ListTile(
                              title: Text(presentation.name),
                            );
                          })),
                    ),
                    AnimatedPositioned(
                        curve: Curves.fastOutSlowIn,
                        width: constraints.maxWidth / 2,
                        height: constraints.maxHeight,
                        left: chapterDetailsController.presentaionListing
                            ? constraints.maxWidth / 2
                            : constraints.maxWidth,
                        top: 0,
                        child: child!,
                        duration: defaultAnimationDuration)
                  ],
                );
              }));
        });
  }
}
