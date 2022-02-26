import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/home_screen/home_controller.dart';

import '../../theme/theme.dart';
import 'components/home_drawer.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = HomeController();
    return Scaffold(
      body: AnimatedBuilder(
          animation: homeController,
          builder: (BuildContext context, Widget? child) {
            return Row(
              children: [
                HomeDrawer(homeController: homeController),
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
                            children: const [
                              ListTile(
                                dense: true,
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                                ),
                                title: Text("Lubshad"),
                                // subtitle: Text("Lead Developer"),
                              ),
                            ],
                          ),
                        ),
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
