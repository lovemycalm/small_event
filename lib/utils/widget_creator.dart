import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:monthsign/constants/resource.dart';
import 'package:tapped/tapped.dart';

Text createText(String? data,
    {Color color = AppColors.black_33,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    int? maxLines,
    TextAlign? textAlign,
    List<Shadow>? shadows,
    double? letterSpacing,
    String? fontFamily,
    double? leading,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none}) {
  if (fontWeight == FontWeight.w500 && Platform.isAndroid) {
    //实测在 android 中前 w500中对于汉字的无效的
    fontWeight = FontWeight.w600;
  }

  return Text(
    data ?? '',
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: maxLines == null ? null : overflow,
    strutStyle: StrutStyle(leading: leading),
    style: normalTextStyle(
        color: color,
        shadows: shadows,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration),
  );
}

TextStyle normalTextStyle(
    {Color color = AppColors.black_33,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    List<Shadow>? shadows,
    double? letterSpacing,
    String? fontFamily,
    TextOverflow overflow = TextOverflow.ellipsis,
    TextDecoration decoration = TextDecoration.none}) {
  return TextStyle(
      color: color,
      shadows: shadows,
      letterSpacing: letterSpacing,
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration);
}

Shadow getTextShadow({Color shadowColor = AppColors.gray99}) {
  return Shadow(offset: Offset(1, 1), blurRadius: 1, color: shadowColor);
}

TextField createTestInputText(String hint,
    {TextEditingController? controller,
    Color textColor = AppColors.black_33,
    Color hintColor = AppColors.gray99,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    int maxLines = 1,
    TextInputType? keyboardType,
    int? maxLength,
    ValueChanged<String>? onChanged,
    double? letterSpacing,
    TextAlign textAlign = TextAlign.start}) {
  return TextField(
    textAlign: textAlign,
    controller: controller,
    style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing),
    maxLines: maxLines,
    inputFormatters: maxLength == null || maxLength <= 0
        ? null
        : [LengthLimitingTextInputFormatter(maxLength)],
    keyboardType: keyboardType,
    // onEditingComplete: (){
    //   Log.look('onEditingComplete!!!');
    // },
    onChanged: onChanged,
    // maxLength: maxLength,
    decoration: InputDecoration(
        hintStyle: TextStyle(color: hintColor),
        hintMaxLines: 100,
        // border: InputBorder.none,
        hintText: hint),
  );
}

TextField createInputText(String hint,
    {TextEditingController? controller,
    Color textColor = AppColors.black_33,
    Color hintColor = AppColors.gray99,
    double fontSize = 14,
    double? hintSize,
    FontWeight fontWeight = FontWeight.normal,
    int? maxLines = 1,
    TextInputType? inputType,
    int? maxLength,
    ValueChanged<String>? onChanged,
    double? letterSpacing,
    TextInputAction? textInputAction,
    bool? enable,
    VoidCallback? onEditingComplete,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onSubmitted,
    GestureTapCallback? onTap,
    bool autofocus = false,
    TextAlign textAlign = TextAlign.start}) {
  List<TextInputFormatter> formatters = inputFormatters ?? [];
  if (maxLength != null && maxLength > 0) {
    formatters.add(LengthLimitingTextInputFormatter(maxLength));
  }

  return TextField(
    textAlign: textAlign,
    autofocus: autofocus,
    controller: controller,
    style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing),
    maxLines: maxLines,
    textInputAction: textInputAction,
    inputFormatters: formatters,
    enabled: enable,
    keyboardType: inputType,
    onChanged: onChanged,
    onTap: onTap,
    maxLength: maxLength,
    onSubmitted: onSubmitted,
    // onSubmitted: null,
    onEditingComplete: onEditingComplete,
    decoration: InputDecoration(
        hintStyle: TextStyle(color: hintColor, fontSize: hintSize),
        hintMaxLines: 100,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent)),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        hintText: hint),
  );
}

Widget createAssetImage(String imagePath,
    {double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    double? scale,
    bool expandWidth = false}) {
  var imageWidget = Image.asset(
    imagePath,
    fit: expandWidth ? BoxFit.fitWidth : fit,
    color: color,
    width: width,
    scale: scale,
    height: height,
    isAntiAlias: true,
  );

  if (expandWidth) {
    return SizedBox(
      width: double.infinity,
      child: imageWidget,
    );
  } else {
    return imageWidget;
  }
}

Widget createButton(String text,
    {double width = double.infinity,
    double height = 43,
    Key? key,
    bool checkLogin = false,
    Color textColor = AppColors.black_33,
    Color? bgColor,
    double? radius,
    Gradient? gradient,
    Border? border,
    double textSize = 15,
    EdgeInsets? margin,
    Function? onTap}) {
  return Container(
    width: width,
    key: key,
    height: height,
    margin: margin,
    decoration: BoxDecoration(
      color: bgColor,
      gradient: gradient,
      border: border,
      // borderRadius: BorderRadius.circular(radius ?? height / 2),
      borderRadius: BorderRadius.circular(radius ?? 8),
    ),
    alignment: Alignment.center,
    child: createText(text, color: textColor, fontSize: textSize),
  ).toClickableWidget(
      onTap: checkLogin
          ? () {
              // if (UserInfoKeeper.instance.checkLogin()) {
              //   onTap?.call();
              // }
            }
          : onTap);
}

Widget createVisibleWidget(bool visible, ValueGetter<Widget> builder) {
  return visible ? builder.call() : Container();
}

Widget createDivider(
    {bool vertical = false, Color color = AppColors.dividerColor}) {
  return vertical
      ? VerticalDivider(
          thickness: 0.5,
          width: 1,
          color: color,
        )
      : Divider(
          color: color,
          thickness: 0.5,
          height: 1,
        );
}

extension ExtWidget on Widget {
  Widget toClickableWidget(
      {Function? onTap, bool showAlpha = true, bool needLogin = false}) {
    if (onTap == null) {
      return this;
    }

    GestureTapCallback finalOnTap = () {
      if (needLogin) {
        // if (UserInfoKeeper.instance.checkLogin()) {
        //   return onTap.call();
        // }
      } else {
        return onTap.call();
      }
    };

    if (showAlpha) {
      return Tapped(
        child: this,
        onTap: finalOnTap,
      );
    } else {
      return GestureDetector(child: this, onTap: finalOnTap);
    }
  }

  Expanded toExpandedWidget({int flex = 1}) {
    return Expanded(
      child: this,
      flex: flex,
    );
  }

  Widget toPaddingWidget(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }

}

///-----------------仅适用于本项目的------------------
