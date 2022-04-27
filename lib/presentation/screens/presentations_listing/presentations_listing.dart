import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/presentation/screens/presentations_listing/presentation_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:folldy_admin/utils/presentation_mode.dart';
import 'package:folldy_admin/utils/url_launcher_utils.dart';

// ignore: must_be_immutable
class PresentationViewArguments extends Equatable {
  PresentationMode presentationMode;
  final String? presentationId;

  PresentationViewArguments(
      {this.presentationMode = PresentationMode.landscape,
      this.presentationId});

  Map<String, dynamic> toJson() => {
        'presentation_mode': presentationMode.index,
        'presentation_id': presentationId
      };

  factory PresentationViewArguments.fromJson(Map<String, dynamic> json) {
    try {
      return PresentationViewArguments(
          presentationMode:
              PresentationMode.values[int.parse(json['presentation_mode'])],
          presentationId: json['presentation_id']);
    } catch (e) {
      return PresentationViewArguments();
    }
  }

  @override
  List<Object?> get props => [presentationId];
}

class PresentationsListing extends StatelessWidget {
  const PresentationsListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PresentationsListingController presentationslistingController =
        PresentationsListingController();

    openPresentationEditor(Presentation presentation) {
      final queryParams = ApiClient.jsonToQuery(PresentationViewArguments(
              presentationMode: PresentationMode.landscape,
              presentationId: presentation.id.toString())
          .toJson());
      final url = Uri.parse(ApiConstants.presentationEditorUrl + queryParams);
      launchInBrowser(url);
    }

    openPresentationViewer(Presentation presentation) {
      final queryParams = ApiClient.jsonToQuery(PresentationViewArguments(
              presentationMode: PresentationMode.landscape,
              presentationId: presentation.id.toString())
          .toJson());
      final url = Uri.parse(ApiConstants.presentationViewerUrl + queryParams);
      launchInBrowser(url);
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
                            onTap: () => openPresentationEditor(e),
                            title: Row(
                              children: [
                                Text(e.name),
                                const Spacer(),
                                IconButton(
                                    onPressed: () => openPresentationViewer(e),
                                    icon:
                                        const Icon(Icons.visibility_outlined)),
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
