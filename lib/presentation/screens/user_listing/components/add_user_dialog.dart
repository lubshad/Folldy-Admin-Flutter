import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/user_listing/user_listing_controller.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserListingController userListingController = Get.find();
    return AlertDialog(
      content: Form(
        key: userListingController.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: userListingController.usernameController,
              decoration: const InputDecoration(label: Text("Username")),
            ),
            TextFormField(
              controller: userListingController.passwordController,
              decoration: const InputDecoration(label: Text("Password")),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
        AnimatedBuilder(
            animation: userListingController,
            builder: (context, child) {
              return ElevatedButton(
                  onPressed: userListingController.buttonLoading
                      ? null
                      : userListingController.createUser,
                  child: const Text("Create User"));
            }),
      ],
    );
  }
}
