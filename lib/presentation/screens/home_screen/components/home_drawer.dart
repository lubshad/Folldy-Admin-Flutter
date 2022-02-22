import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/screens/home_screen/home_controller.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
            child: Text(
              "Folldy",
              style: Theme.of(context).textTheme.headline5,
            ),
          )),
          ...drawerItems
              .map((e) => ListTile(
                    selected: homeController.selectedItem == e,
                    onTap: () => homeController.selectItem(e),
                    title: Text(e.text),
                    leading: Icon(e.icon),
                  ))
              .toList()
        ],
      ),
    );
  }
}
