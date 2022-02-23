import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/institutions_listing/institution_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/app_theme.dart';

class InstitutionsListing extends StatelessWidget {
  const InstitutionsListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InstitutionListingController institutionListingController =
        InstitutionListingController();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: institutionListingController.showAddinstitutionDialog,
                label: const Text("Add New Institution"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: institutionListingController,
            builder: (BuildContext context, Widget? child) {
              return ListView(
                children: institutionListingController.institutions
                    .map((e) => ListTile(
                          title: Row(
                            children: [
                              Text(e.name),
                              const Spacer(),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        institutionListingController
                                            .deleteInstitution(e),
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
