import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/areas_listing/areas_listing_controller.dart';
import 'package:folldy_admin/presentation/screens/presentations_listing/presentations_listing.dart';
import 'package:folldy_admin/presentation/screens/universities_listing/universities_listing.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class AreaVisePresentationListing extends StatelessWidget {
  const AreaVisePresentationListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AreasListingController areasListingController = Get.find();
    areasListingController.searchAreaController.text = "";
    areasListingController.getAreas();
    return Row(
      children: [
        Drawer(
          child: Column(
            children: [
              SizedBox(
                height: defaultPaddingLarge * 2,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Area',
                          prefixIcon: Icon(Icons.search),
                        ),
                        controller: areasListingController.searchAreaController,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: areasListingController.showAddAreaDialog,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: AnimatedBuilder(
                    animation: Listenable.merge([
                      areasListingController,
                      areasListingController.searchAreaController
                    ]),
                    builder: (context, child) {
                      final areas = areasListingController.areas
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(areasListingController
                                  .searchAreaController.text
                                  .toLowerCase()))
                          .toList();
                      return ListView.builder(
                          controller: ScrollController(),
                          itemCount: areas.length,
                          itemBuilder: ((context, index) =>
                              Builder(builder: (context) {
                                final area = areas[index];
                                return ListTile(
                                  dense: true,
                                  trailing: PopupMenuButton<PopupOptions>(
                                      onSelected: (value) =>
                                          areasListingController
                                              .onDropdownSelection(value, area),
                                      itemBuilder: ((context) => PopupOptions
                                          .values
                                          .map((e) => PopupMenuItem(
                                              child: Text(e.title), value: e))
                                          .toList())),
                                  onTap: () =>
                                      areasListingController.selectArea(area),
                                  selected: areasListingController
                                      .selectionValue(area),
                                  key: Key(area.id.toString()),
                                  title: Text(area.name),
                                );
                              })));
                    }),
              )
            ],
          ),
        ),
        const VerticalDivider(),
        Expanded(
            child: AnimatedBuilder(
                animation: areasListingController,
                builder: (context, child) {
                  return PresentationsListing(
                    area: areasListingController.selectedArea,
                  );
                })),
      ],
    );
  }
}
