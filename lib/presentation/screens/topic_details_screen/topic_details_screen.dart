import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/topic_details_screen/topic_details_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class TopicDetailsScreen extends StatelessWidget {
  const TopicDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TopicDetailsController topicDetailsController = TopicDetailsController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Introduction to banking"),
      ),
      body: AnimatedBuilder(
          animation: topicDetailsController,
          builder: (BuildContext context, Widget? child) {
            return Row(
              children: [
                Expanded(
                  child: GridView(
                      padding: const EdgeInsets.all(defaultPadding),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: slideAspectRatio,
                              crossAxisCount: 4,
                              crossAxisSpacing: defaultPadding,
                              mainAxisSpacing: defaultPadding),
                      children: [
                        ...topicDetailsController.presentations
                            .map((e) => GestureDetector(
                                  onTap: () => topicDetailsController
                                      .changePresentation(e),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          defaultPaddingSmall),
                                      child: Image.network(
                                          "http://127.0.0.1:8000" +
                                              e.teacher.profile)),
                                )),
                        TextButton(
                            onPressed: topicDetailsController
                                .showAddPresentationDialog,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add),
                                Text("Add New Presentation"),
                              ],
                            ))
                      ]),
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    return topicDetailsController.selectedPresentation == null
                        ? Container()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                child: Row(
                                  children: [
                                    ...topicDetailsController
                                        .selectedPresentation!.slides
                                        .map((e) => SizedBox(
                                              width: 200,
                                              child: AspectRatio(
                                                aspectRatio: slideAspectRatio,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            defaultPaddingSmall),
                                                    child: Image.network(
                                                        "http://127.0.0.1:8000" +
                                                            e.slide)),
                                              ),
                                            )),
                                    TextButton(
                                        onPressed:
                                            topicDetailsController.pickFile,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.add),
                                            Text("Add New Slide"),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                              defaultSpacerLarge,
                              ...topicDetailsController
                                  .selectedPresentation!.audios
                                  .map((e) => ListTile(
                                      leading: Text(e.id.toString()),
                                      title: Text("Audio: " + e.audio))),
                              TextButton(
                                  onPressed: topicDetailsController.pickAudio,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.add),
                                      Text("Add New Audio"),
                                    ],
                                  ))
                            ],
                          );
                    // : GridView(
                    //     scrollDirection: Axis.horizontal,
                    //     padding: const EdgeInsets.all(defaultPadding),
                    //     gridDelegate:
                    //         const SliverGridDelegateWithFixedCrossAxisCount(
                    //             childAspectRatio: slideAspectRatio,
                    //             crossAxisCount: 1,
                    //             crossAxisSpacing: defaultPadding,
                    //             mainAxisSpacing: defaultPadding),
                    //     children: [
                    //         ...topicDetailsController
                    //             .selectedPresentation!.slides
                    //             .map((e) => ClipRRect(
                    //                 borderRadius: BorderRadius.circular(
                    //                     defaultPaddingSmall),
                    //                 child: Image.network(
                    //                     "http://127.0.0.1:8000" +
                    //                         e.slide))),
                    //         TextButton(
                    //             onPressed: topicDetailsController.pickFile,
                    //             child: Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.center,
                    //               children: const [
                    //                 Icon(Icons.add),
                    //                 Text("Add New Slide"),
                    //               ],
                    //             ))
                    //       ]);
                  }),
                ),
              ],
            );
          }),
    );
  }
}
