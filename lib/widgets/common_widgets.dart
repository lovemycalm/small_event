import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///当 dart 为 true 时,状态栏是黑色的。
class StateBarWrapper extends StatelessWidget {
  final Widget child;
  final bool dark;

  const StateBarWrapper({
    Key? key,
    required this.child,
    this.dark = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: dark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: child,
    );
  }
}