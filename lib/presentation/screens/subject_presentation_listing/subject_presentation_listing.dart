import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_utils/data/models/subject_list_response.dart';
import 'package:folldy_admin/presentation/screens/subject_presentation_listing/subject_details_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

import '../../components/error_message_with_retry.dart';
import '../area_selection_listing/area_selection_listing.dart';

class SubjectPresentationListing extends StatelessWidget {
  const SubjectPresentationListing({
    Key? key,
    required this.subject,
  }) : super(key: key);
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SubjectPresentationsController());
    SubjectPresentationsController subjectDetailsController = Get.find();
    subjectDetailsController.init(subject);
    return Column(children: [
      AnimatedBuilder(
          animation: subjectDetailsController,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!subjectDetailsController.areaListing &&
                    !subjectDetailsController.presentaionListing)
                  TextButton.icon(
                      onPressed: subjectDetailsController.tougleAreaLising,
                      icon: const Icon(Icons.download),
                      label: const Text("Import Presentaions from Area")),
                if (!subjectDetailsController.areaListing &&
                    !subjectDetailsController.presentaionListing)
                  TextButton.icon(
                      onPressed:
                          subjectDetailsController.touglePresentationListing,
                      icon: const Icon(Icons.download),
                      label: const Text("Import Presentaions")),
                if (subjectDetailsController.areaListing ||
                    subjectDetailsController.presentaionListing)
                  TextButton(
                      onPressed: subjectDetailsController.hideAndResetSelection,
                      child: const Text("Done"))
              ],
            );
          }),
      Expanded(child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            AnimatedBuilder(
                animation: subjectDetailsController,
                builder: (context, child) {
                  return NetworkResource(
                    errorWidget: Builder(builder: (context) {
                      return ErrorMessageWithRetry(
                          error: subjectDetailsController.appError!,
                          retry: subjectDetailsController.retry);
                    }),
                    error: subjectDetailsController.appError,
                    isLoading: subjectDetailsController.isLoading,
                    child: ListView.builder(
                        itemCount:
                            subjectDetailsController.presentations.length,
                        itemBuilder: ((context, index) {
                          final presentation =
                              subjectDetailsController.presentations[index];
                          return ListTile(
                            title: Text(presentation.name),
                          );
                        })),
                  );
                }),
            // AnimatedBuilder(
            //     // child: PresentationSelectionListing(
            //     //     addPresentations: (presentations) =>
            //     //         subjectDetailsController
            //     //             .addPresentationss(presentations)),
            //     animation: subjectDetailsController,
            //     builder: (context, child) {
            //       return AnimatedPositioned(
            //           curve: Curves.fastOutSlowIn,
            //           width: constraints.maxWidth / 2,
            //           height: constraints.maxHeight,
            //           left: subjectDetailsController.presentaionListing
            //               ? constraints.maxWidth / 2
            //               : constraints.maxWidth,
            //           top: 0,
            //           child: child!,
            //           duration: defaultAnimationDuration);
            //     }),
            AnimatedBuilder(
                child: AreaSelectionListing(
                  addAreas: (areas) => subjectDetailsController.addAreas(areas),
                ),
                animation: subjectDetailsController,
                builder: (context, child) {
                  return AnimatedPositioned(
                      curve: Curves.fastOutSlowIn,
                      width: constraints.maxWidth / 2,
                      height: constraints.maxHeight,
                      left: subjectDetailsController.areaListing
                          ? constraints.maxWidth / 2
                          : constraints.maxWidth,
                      top: 0,
                      child: child!,
                      duration: defaultAnimationDuration);
                }),
          ],
        );
      })),
    ]);
  }
}
