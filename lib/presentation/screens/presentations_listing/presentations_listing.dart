import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/data/core/api_constants.dart';
import 'package:folldy_admin/data/models/presentation_list_response.dart';
import 'package:folldy_admin/presentation/screens/presentations_listing/presentation_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';
import 'package:folldy_admin/utils/presentation_mode.dart';
import 'package:folldy_admin/utils/url_launcher_utils.dart';

import '../../../data/models/area_list_response.dart';

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
    required this.area,
  }) : super(key: key);

  final Area? area;

  @override
  Widget build(BuildContext context) {
    PresentationsListingController presentationslistingController = Get.find();

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

    presentationslistingController.searchPresentationController.text = "";
    presentationslistingController.selectedArea = area;
    presentationslistingController.getPresentations();
    // presentationslistingController.searchPresentationController.addListener(() {
    //   presentationslistingController.getPresentations();
    // });

    return Column(
      children: [
        Container(
          height: defaultPaddingLarge * 2,
          padding: const EdgeInsets.all(defaultPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            area?.name ?? "Public",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Search Presentation',
              suffixIcon: Icon(Icons.search),
            ),
            controller:
                presentationslistingController.searchPresentationController,
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              presentationslistingController,
              presentationslistingController.searchPresentationController,
            ]),
            builder: (BuildContext context, Widget? child) {
              final modulevisePresntations =
                  presentationslistingController.moduleVisePresentations;
              return ListView.builder(
                  itemCount: modulevisePresntations.length + 1,
                  itemBuilder: ((context, index) => Builder(builder: (context) {
                        if (index == modulevisePresntations.length) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: TextButton(
                                    onPressed: presentationslistingController
                                        .addModule,
                                    child: const Text("Add Module")),
                              ),
                            ],
                          );
                        }
                        final module = modulevisePresntations[index];
                        List<Presentation> presentations =
                            presentationListResponseFromJson(
                                module["presentations"]);
                        return ExpansionTile(
                          // initiallyExpanded: true,
                          title: Text("Module ${module["module"]}"),
                          trailing: TextButton(
                              onPressed: () => presentationslistingController
                                  .showAddEditPresentaion(
                                      module: module["module"] as int),
                              child: const Text("Add Presentation")),
                          controlAffinity: ListTileControlAffinity.leading,
                          childrenPadding:
                              const EdgeInsets.only(left: defaultPadding),
                          children: presentationslistingController
                              .searchResult(presentations)
                              .map((presentation) => Draggable(
                                    data: presentation,
                                    feedback: Material(
                                        child: Text(presentation.name)),
                                    child: ListTile(
                                        key: Key(presentation.id.toString()),
                                        onTap: () => openPresentationEditor(
                                            presentation),
                                        title: Row(
                                          children: [
                                            Text(presentation.name),
                                            const Spacer(),
                                            IconButton(
                                                onPressed: () =>
                                                    openPresentationViewer(
                                                        presentation),
                                                icon: const Icon(
                                                    Icons.visibility_outlined)),
                                            IconButton(
                                                onPressed: () =>
                                                    presentationslistingController
                                                        .showAddEditPresentaion(
                                                            presentation:
                                                                presentation),
                                                icon: const Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () =>
                                                    presentationslistingController
                                                        .showDeletePresentationConfirmation(
                                                            presentation),
                                                icon: const Icon(Icons.delete)),
                                          ],
                                        )),
                                  ))
                              .toList(),
                        );
                      })));
            },
          ),
        ),
      ],
    );
  }
}
