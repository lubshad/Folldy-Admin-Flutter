import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/subject_list_response.dart';
import 'package:folldy_admin/presentation/components/error_message_with_retry.dart';
import 'package:folldy_admin/presentation/screens/area_selection_listing/area_selection_listing.dart';
import 'package:folldy_admin/presentation/screens/presentation_selection_listing/presentation_selection_listing.dart';
import 'package:folldy_admin/presentation/screens/subject_details/subject_details_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class SubjectDetails extends StatelessWidget {
  const SubjectDetails({
    Key? key,
    required this.subject,
  }) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SubjectDetailsController());
    SubjectDetailsController subjectDetailsController = Get.find();
    subjectDetailsController.init(subject);
    return Scaffold(
        appBar: AppBar(
          title: Text(subject.name),
          actions: [
            AnimatedBuilder(
                child: Container(),
                animation: subjectDetailsController,
                builder: (context, child) {
                  if (subjectDetailsController.presentaionListing) {
                    return child!;
                  }
                  return TextButton(
                      onPressed: subjectDetailsController.tougleAreaLising,
                      child: Row(
                        children: [
                          if (!subjectDetailsController.areaListing)
                            const Icon(Icons.add),
                          Text(subjectDetailsController.areaListing
                              ? "Done"
                              : 'Add from area'),
                        ],
                      ));
                }),
            AnimatedBuilder(
                child: Container(),
                animation: subjectDetailsController,
                builder: (context, child) {
                  if (subjectDetailsController.areaListing) return child!;
                  return TextButton(
                      onPressed:
                          subjectDetailsController.touglePresentationListing,
                      child: Row(
                        children: [
                          if (!subjectDetailsController.presentaionListing)
                            const Icon(Icons.add),
                          Text(subjectDetailsController.presentaionListing
                              ? "Done"
                              : 'Add Presentation'),
                        ],
                      ));
                })
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
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
              AnimatedBuilder(
                  child: PresentationSelectionListing(
                      addPresentations:(presentations) => 
                          subjectDetailsController.addPresentationss(presentations)),
                  animation: subjectDetailsController,
                  builder: (context, child) {
                    return AnimatedPositioned(
                        curve: Curves.fastOutSlowIn,
                        width: constraints.maxWidth / 2,
                        height: constraints.maxHeight,
                        left: subjectDetailsController.presentaionListing
                            ? constraints.maxWidth / 2
                            : constraints.maxWidth,
                        top: 0,
                        child: child!,
                        duration: defaultAnimationDuration);
                  }),
              AnimatedBuilder(
                  child:  AreaSelectionListing(
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
        }));
  }
}

