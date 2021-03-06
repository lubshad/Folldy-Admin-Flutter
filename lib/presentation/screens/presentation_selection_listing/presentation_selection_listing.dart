import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/presentation_selection_listing/presentation_selection_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class PresentationSelectionListing extends StatelessWidget {
  const PresentationSelectionListing({
    Key? key,
    required this.addPresentations,
  }) : super(key: key);
  final Function(List<Map<String, dynamic>> presentations) addPresentations;

  @override
  Widget build(BuildContext context) {
    PresentationSelectionController presentationSelectionController =
        PresentationSelectionController();
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
              // title: child,
              actions: [
                if (presentationSelectionController
                    .selectedPresentations.isNotEmpty)
                  TextButton.icon(
                      icon: const Icon(Icons.download),
                      onPressed: () {
                        addPresentations(presentationSelectionController
                            .selectedPresentations
                            .toList());
                        presentationSelectionController.clear();
                      },
                      label: const Text("Import selected presentaion"))
              ],
            ),
            body: ListView.builder(
                controller: ScrollController(),
                itemCount: presentationSelectionController
                    .areavisePresentations.length,
                itemBuilder: (context, index) {
                  final area = presentationSelectionController
                      .areavisePresentations[index];
                  List<Map<String, dynamic>> modules = area["modules"];
                  return ExpansionTile(
                    childrenPadding:
                        const EdgeInsets.only(left: defaultPadding),
                    key: Key(area["id"].toString()),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(area["name"]),
                    children: modules
                        .map((module) => Builder(builder: (context) {
                              List presentations = module["presentations"];
                              return ExpansionTile(
                                leading: Checkbox(
                                    value: presentationSelectionController
                                        .moduleSelectionStatus(presentations),
                                    onChanged: (val) => presentationSelectionController
                                        .selectModule(presentations , val)),
                                childrenPadding:
                                    const EdgeInsets.only(left: defaultPadding),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                title: Text(module["module"].toString()),
                                children: presentations
                                    .map((presentation) => CheckboxListTile(
                                        contentPadding: const EdgeInsets.only(
                                            left: defaultPadding),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text(presentation["name"]),
                                        value: presentationSelectionController
                                            .selectionValue(presentation),
                                        onChanged: (val) =>
                                            presentationSelectionController
                                                .selectPresentation(
                                                    presentation)))
                                    .toList(),
                              );
                            }))
                        .toList(),
                    // onChanged: (value) =>
                    //     presentationSelectionController.onChanged(presentation),
                    // value: presentationSelectionController
                    //     .selectionValue(presentation),
                  );
                }),
          );
        });
  }
}
