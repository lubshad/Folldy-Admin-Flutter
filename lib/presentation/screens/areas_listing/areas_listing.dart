import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/areas_listing/areas_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class AreasListing extends StatelessWidget {
  const AreasListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AreasListingController());
    AreasListingController arealistingController = Get.find();
    arealistingController.searchAreaController.text = "";
    arealistingController.getData();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search Area',
                    suffixIcon: Icon(Icons.search),
                  ),
                  controller: arealistingController.searchAreaController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: TextButton.icon(
                onPressed: arealistingController.showAddAreaDialog,
                label: const Text("Add New Area"),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              arealistingController,
              arealistingController.searchAreaController
            ]),
            builder: (BuildContext context, Widget? child) {
              List filteredAreas = arealistingController.areas
                  .where((element) => element.name.toLowerCase().contains(
                      arealistingController.searchAreaController.text
                          .toLowerCase()))
                  .toList();
              return NetworkResource(
                error: arealistingController.appError,
                isLoading: arealistingController.isLoading,
                child: ListView.builder(
                  itemCount: filteredAreas.length,
                  itemBuilder: (BuildContext context, int index) {
                    final area = filteredAreas[index];
                    return ListTile(
                      key: Key(area.id.toString()),
                      title: Row(
                        children: [
                          Text(area.name),
                          const Spacer(),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () => arealistingController
                                  .showAreaDeleteConfirmation(area),
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
