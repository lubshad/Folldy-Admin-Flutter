import 'package:basic_template/basic_template.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/auth_wrapper/auth_controller.dart';
import 'package:folldy_admin/presentation/screens/home_screen/home_controller.dart';

import '../../theme/theme.dart';
import 'components/home_drawer.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    AuthController authController = Get.find();
    return Scaffold(
      body: AnimatedBuilder(
          animation: homeController,
          builder: (BuildContext context, Widget? child) {
            return Row(
              children: [
                HomeDrawer(homeController: homeController),
                const VerticalDivider(),
                Expanded(
                    child: Column(
                  children: [
                    AppBar(
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.message)),
                        SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/pngs/no_image.png"),
                                ),
                                title: Text(authController.user!["username"]),
                                // subtitle: Text("Lead Developer"),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: authController.logout,
                            icon: const Icon(Icons.logout)),
                        defaultSpacerHorizontal,
                      ],
                    ),
                    Expanded(child: homeController.selectedItem.body),
                  ],
                ))
              ],
            );
          }),
    );
  }
}
