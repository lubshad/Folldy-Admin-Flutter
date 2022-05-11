import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/components/error_message_with_retry.dart';
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
    arealistingController.getData();

    return AnimatedBuilder(
        animation: arealistingController,
        builder: (context, child) {
          return NetworkResource(
            error: arealistingController.appError,
            isLoading: arealistingController.isLoading,
            errorWidget: Builder(builder: (context) {
              return ErrorMessageWithRetry(
                  error: arealistingController.appError!,
                  retry: arealistingController.retry);
            }),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    animation: arealistingController,
                    builder: (BuildContext context, Widget? child) {
                      return ListView(
                          children: arealistingController.areas
                              .map((e) => ListTile(
                                    title: Row(
                                      children: [
                                        Text(e.name),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit)),
                                        IconButton(
                                            onPressed: () =>
                                                arealistingController
                                                    .showAreaDeleteConfirmation(e),
                                            icon: const Icon(Icons.delete)),
                                      ],
                                    ),
                                  ))
                              .toList());
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
