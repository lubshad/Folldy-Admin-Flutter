import 'package:flutter/material.dart';

import '../theme/theme.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    Key? key,
    required this.text,
    this.padding = true,
  }) : super(key: key);

  final String text;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
            top: !padding ? 0 : defaultPaddingLarge,
            left: defaultPadding,
            bottom: !padding ? 0 : defaultPaddingSmall),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ));
  }
}
