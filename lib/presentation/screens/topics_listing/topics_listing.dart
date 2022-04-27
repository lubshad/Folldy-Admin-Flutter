import 'package:flutter/material.dart';
import 'package:folldy_admin/data/models/topic_list_response.dart';
import 'package:folldy_admin/presentation/screens/topics_listing/topic_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class TopicsListing extends StatelessWidget {
  const TopicsListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TopicListingController topiclistingController = TopicListingController();

    openPresentationEditor(Topic topic) {
      // final url = Uri.http(
      //     ApiConstants.domainUrl,
      //     ApiConstants.presentationEditorUrl
      //     ,

      // )
      // launchInBrowser(url);
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: topiclistingController.showAddTopicDialog,
                label: const Text("Add New Topic"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: topiclistingController,
            builder: (BuildContext context, Widget? child) {
              return ListView(
                  children: topiclistingController.topics
                      .map((e) => ListTile(
                            onTap: () => openPresentationEditor(e),
                            title: Row(
                              children: [
                                Text(e.name),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () => topiclistingController
                                        .deleteSelectedTopic(e),
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ))
                      .toList());
            },
          ),
        ),
      ],
    );
  }
}
