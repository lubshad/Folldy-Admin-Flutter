import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/presentation/screens/presentation_selection_listing/presentation_selection_controller.dart';

class PresentationSelectionListing extends StatelessWidget {
  const PresentationSelectionListing({
    Key? key,
    required this.addPresentations,
    this.subjectId,
    this.chapterId,
  }) : super(key: key);
  final Function(List<Presentation> presentations) addPresentations;
  final int? subjectId;
  final int? chapterId;

  @override
  Widget build(BuildContext context) {
    PresentationSelectionController presentationSelectionController =
        PresentationSelectionController(
            subjectId: subjectId, chapterId: chapterId);
    // ChapterDetailsController chapterDetailsController = Get.find();
    presentationSelectionController.getPresentations();

    presentationSelectionController.searchPresentationController
        .addListener(() {
      presentationSelectionController.getPresentations();
    });

    return AnimatedBuilder(
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Search Presentation',
            suffixIcon: Icon(Icons.search),
          ),
          controller:
              presentationSelectionController.searchPresentationController,
        ),
        animation: presentationSelectionController,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: child,
              actions: [
                if (presentationSelectionController
                    .selectedPresentations.isNotEmpty)
                  TextButton.icon(
                      icon: const Icon(Icons.download),
                      onPressed: () => addPresentations(
                          presentationSelectionController
                              .selectedPresentations),
                      label: const Text("Import selected presentaion"))
              ],
            ),
            body: ListView.builder(
                controller: ScrollController(),
                itemCount: presentationSelectionController.presentations.length,
                itemBuilder: (context, index) {
                  final presentation =
                      presentationSelectionController.presentations[index];
                  return CheckboxListTile(
                    key: Key(presentation.id.toString()),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(presentation.name),
                    onChanged: (value) =>
                        presentationSelectionController.onChanged(presentation),
                    value: presentationSelectionController
                        .selectionValue(presentation),
                  );
                }),
          );
        });
  }
}
