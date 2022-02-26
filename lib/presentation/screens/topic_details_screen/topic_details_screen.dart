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
                        ...topicDetailsController.pickedImages.map((e) =>
                            ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(defaultPaddingSmall),
                                child: Image.memory(e.bytes!))),
                        TextButton(
                            onPressed: topicDetailsController.pickFile,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add),
                                Text("Add New Slide"),
                              ],
                            ))
                      ]),
                ),
                Expanded(child: Container())
              ],
            );
          }),
    );
  }
}
