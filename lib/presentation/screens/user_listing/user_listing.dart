import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/components/error_message_with_retry.dart';
import 'package:folldy_admin/presentation/screens/user_listing/user_listing_controller.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class UserListing extends StatelessWidget {
  const UserListing({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserListingController userListingController = Get.find();
    userListingController.getData();
    return AnimatedBuilder(
        animation: userListingController,
        builder: (context, child) {
          return NetworkResource(
              errorWidget: Builder(builder: (context) {
                return ErrorMessageWithRetry(
                    error: userListingController.appError!,
                    retry: userListingController.retry);
              }),
              child: Column(
                children: [
                  Container(
                    height: defaultPaddingLarge * 2,
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Users",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        TextButton.icon(
                          onPressed: userListingController.showAddUserDialog,
                          label: const Text("Add New User"),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                        itemCount: userListingController.users.length,
                        itemBuilder: ((context, index) =>
                            Builder(builder: (context) {
                              final user = userListingController.users[index];
                              return ListTile(
                                title: Text(user["username"]),
                              );
                            }))),
                  ),
                ],
              ),
              error: userListingController.appError,
              isLoading: userListingController.isLoading);
        });
  }
}
