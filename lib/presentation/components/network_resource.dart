import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class NetworkResource extends StatelessWidget {
  const NetworkResource(
      {Key? key,
      required this.loading,
      this.loadingWidget,
      required this.child})
      : super(key: key);

  final bool loading;
  final Widget? loadingWidget;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (child, animation, secondaryAnimation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: loading
          ? loadingWidget == null
              ? const Center(child: CircularProgressIndicator())
              : loadingWidget!
          : child,
    );
  }
}
