import 'package:flutter/material.dart';
import 'package:folldy_admin/presentation/theme/theme.dart';

class TemplatesMenuDetails extends StatelessWidget {
  const TemplatesMenuDetails({
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
            hintText: "Search Templates here",
            prefixIcon: Icon(Icons.search),
          )),
        ],
      ),
    );
  }
}
