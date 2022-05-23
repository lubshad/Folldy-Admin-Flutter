import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/institutions_listing/institution_listing_controller.dart';
import 'package:folldy_admin/presentation/screens/universities_listing/universities_listing.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

import '../faculty_listing/faculties_listing.dart';

class InstitutionsListing extends StatelessWidget {
  const InstitutionsListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InstitutionListingController institutionListingController =
        InstitutionListingController();
    institutionListingController.getInstitutions();

    return Row(
      children: [
        Drawer(
          child: Column(
            children: [
              SizedBox(
                height: defaultPaddingLarge * 2,
                // padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            hintText: 'Search Institution',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none),
                        controller: institutionListingController
                            .searchInstitutionController,
                      ),
                    ),
                    IconButton(
                        onPressed: () => institutionListingController
                            .addEditInstitutionDialog(),
                        icon: const Icon(Icons.add))
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                  child: AnimatedBuilder(
                      animation: Listenable.merge([
                        institutionListingController,
                        institutionListingController.searchInstitutionController
                      ]),
                      builder: (context, child) {
                        final institutions = institutionListingController
                            .institutions
                            .where((element) => element.name
                                .toLowerCase()
                                .contains(institutionListingController
                                    .searchInstitutionController.text
                                    .toLowerCase()))
                            .toList();
                        return ListView.builder(
                            itemCount: institutions.length,
                            itemBuilder: (context, index) =>
                                Builder(builder: (context) {
                                  final institution = institutions[index];
                                  return ListTile(
                                    selected: institutionListingController
                                            .selectedInstitution?.id ==
                                        institution.id,
                                    onTap: () => institutionListingController
                                        .selectInstitution(institution),
                                    title: Text(institution.name),
                                    trailing: PopupMenuButton<PopupOptions>(
                                        itemBuilder: ((context) => PopupOptions
                                            .values
                                            .map((e) => PopupMenuItem(
                                                child: Text(e.title), value: e))
                                            .toList()),
                                        onSelected: (val) =>
                                            institutionListingController
                                                .onOptionSelected(
                                                    val, institution)),
                                  );
                                }));
                      }))
            ],
          ),
        ),
        const VerticalDivider(),
        Expanded(
            child: AnimatedBuilder(
                animation: institutionListingController,
                builder: (context, child) {
                  return FacultyListing(
                    institution:
                        institutionListingController.selectedInstitution,
                  );
                }))
      ],
    );
  }
}
