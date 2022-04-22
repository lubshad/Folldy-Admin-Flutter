import 'package:flutter/material.dart';
import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/presentation/screens/presentations_listing/presentation_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:folldy_admin/utils/url_launcher_utils.dart';

class PresentationsListing extends StatelessWidget {
  const PresentationsListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PresentationsListingController presentationslistingController =
        PresentationsListingController();

    openPresentationEditor(Presentation presentation) {
      final url = Uri.http(
          ApiConstants.presentationDomain,
          ApiConstants.presentationEditorUrl,
          {"presentation_id": presentation.id.toString()}).toString();
      launchInBrowser(url.toString());
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed:
                    presentationslistingController.showAddPresentationDialog,
                label: const Text("Add New Presentation"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: presentationslistingController,
            builder: (BuildContext context, Widget? child) {
              return ListView(
                  children: presentationslistingController.presentations
                      .map((e) => ListTile(
                            // onTap: () => openPresentationEditor(e),
                            title: Row(
                              children: [
                                Text(e.name),
                                const Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () =>
                                        presentationslistingController
                                            .deleteSelectedPresentation(e),
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
