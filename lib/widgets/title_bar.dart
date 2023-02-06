import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monthsign/utils/route.dart';
import 'package:monthsign/utils/widget_creator.dart';
import 'package:tapped/tapped.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color childColor;
  final Color backgroundColor;
  final bool showBorder;
  final Widget? rightWidget;
  final Function? onBackPress;
  final SystemUiOverlayStyle? overlayStyle;
  final bool hideBackIcon;
  final Widget? centerWidget;

  static final double titleBarHeight = 50;

  const TitleBar({
    Key? key,
    this.title = '',
    this.childColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.showBorder = true,
    this.rightWidget,
    this.onBackPress,
    this.overlayStyle,
    this.hideBackIcon = false,
    this.centerWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return AppBar(
    //   title: Text(title ?? ''),
    // );

    SystemUiOverlayStyle finalStyle;
    if (overlayStyle == null) {
      finalStyle = backgroundColor == Colors.white
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light;
    } else {
      finalStyle = overlayStyle!;
    }

    Border? border;
    if (showBorder) {
      border = Border(
          bottom: BorderSide(
              width: 0.5,
              color: Colors.grey.withOpacity(0.7),
              style: BorderStyle.solid));
    }

    Widget titleWidget;
    if (centerWidget == null) {
      titleWidget = createText(title,
          color: childColor, fontSize: 18, fontWeight: FontWeight.w500);
    } else {
      titleWidget = centerWidget!;
    }

    //AnnotatedRegion 意思是只改变以下范围的样式
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: finalStyle,
      child: Container(
        color: backgroundColor,
        child: SafeArea(
          bottom: false,
          child: Container(
            height: titleBarHeight,
            decoration: BoxDecoration(
              border: border,
            ),
            child: Stack(
              children: <Widget>[
                Center(
                  child: titleWidget,
                ),
                if (!hideBackIcon)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BackBtn(
//                      bgColor: bgColor,
                        onBackPress: onBackPress,
                        // backIcon: backIcon,
                        childColor: childColor),
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: rightWidget,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, titleBarHeight);
}

class BackBtn extends StatelessWidget {
  const BackBtn({
    Key? key,
//    this.bgColor = Colors.white,
    this.onBackPress,
    // this.backIcon = R.IC_BACK,
    this.childColor = Colors.black,
  }) : super(key: key);

//  final Color bgColor;
  final Function? onBackPress;

  // final String backIcon;
  final Color childColor;

  @override
  Widget build(BuildContext context) {
    return Tapped(
      onTap: onBackPress ??
          () {
            FocusScope.of(context).requestFocus(FocusNode());
            ARouter.back();
          },
      child: Container(
        color: Colors.transparent,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        // child: ImageIcon(
        //   AssetImage(backIcon),
        //   color: childColor,
        // ),
        child: Icon(
          Icons.arrow_back_ios,
          color: childColor,
        ),
      ),
    );
  }
}
