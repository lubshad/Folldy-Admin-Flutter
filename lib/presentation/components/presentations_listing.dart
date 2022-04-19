import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class PresentationsMenuDetails extends StatelessWidget {
  const PresentationsMenuDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
            hintText: "Search presentations here",
            prefixIcon: Icon(Icons.search),
          )),
        ],
      ),
    );
  }
}
