import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/area_selection_listing/area_selection_controller.dart';
import 'package:folldy_utils/data/models/area_list_response.dart';

class AreaSelectionListing extends StatelessWidget {
  const AreaSelectionListing({
    Key? key,
    required this.addAreas,
    this.subjectId,
    this.chapterId,
  }) : super(key: key);
  final Function(List<Area>) addAreas;
  final int? subjectId;
  final int? chapterId;

  @override
  Widget build(BuildContext context) {
    AreaSelectionController areaSelectionController =
        AreaSelectionController(subjectId: subjectId, chapterId: chapterId);
    // ChapterDetailsController chapterDetailsController = Get.find();
    areaSelectionController.getArea();

    areaSelectionController.searchAreaController.addListener(() {
      areaSelectionController.getArea();
    });

    return AnimatedBuilder(
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Search Area',
            suffixIcon: Icon(Icons.search),
          ),
          controller: areaSelectionController.searchAreaController,
        ),
        animation: areaSelectionController,
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: child,
              actions: [
                if (areaSelectionController.selectedArea.isNotEmpty)
                  TextButton.icon(
                      icon: const Icon(Icons.download),
                      onPressed: () {
                        addAreas(areaSelectionController.selectedArea);
                        areaSelectionController.clear();
                      },
                      label: const Text("Import selected areas"))
              ],
            ),
            body: ListView.builder(
                controller: ScrollController(),
                itemCount: areaSelectionController.areas.length,
                itemBuilder: (context, index) {
                  final presentation = areaSelectionController.areas[index];
                  return CheckboxListTile(
                    key: Key(presentation.id.toString()),
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(presentation.name),
                    onChanged: (value) =>
                        areaSelectionController.onChanged(presentation),
                    value: areaSelectionController.selectionValue(presentation),
                  );
                }),
          );
        });
  }
}
