import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ARouter {

  static get index => null;

  // static String beforeRouteName;

  static Future pushByWidget(BuildContext context, Widget widget,
      {NavigatorState? navigatorState}) {
    return Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

}
