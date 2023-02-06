import 'dart:ui';

import 'package:flutter/cupertino.dart';

//9a 是60%
class AppColors {
  AppColors._();

//  static const Color mainColor = Color(0xFFF4C735);
  static const Color black_1a = Color(0xFF1a1a1a);
  static const Color black_1e = Color(0xFF1e1e1e);
  static const Color grayF8 = Color(0xFFf8f8f8);
  static const Color grayF8f9fc = Color(0xFFf8f9fc);
  static const Color grayBa = Color(0xFFbababa);
  static const Color grayCC = Color(0xffcccccc);
  static const Color grayF5 = Color(0xfff5f5f5);

  static const Color disableRed = Color(0xFFeb3535);
  static const Color clickableTextColor = Color(0xff4e78e2);

  static const Color shadowColor = Color(0x33c4c5cc);
  static const Color priceRed = Color(0xFFF6001C);
  static const Color commonRed = Color(0xFFF6001C);
  static const Color noticeRed = Color(0xFFF6001C);
  static const Color colorEb3535 = Color(0xFFeb3535);
  static const Color colorFc4d06 = Color(0xFFfc4d06);
  static const Color dark2b4484 = Color(0xff2b4484);
  static const Color dark353747 = Color(0xff353747);
  static const Color dark2b6c83 = Color(0xff2b6c83);
  static const Color redFf4a00 = Color(0xffff4a00);

  ///以下是设计规范上的颜色
//  static const Color commonGreen=Color(0xff8CC63F);
  //主色
  static const Color mainColor = Color(0xff53B3FF);
  static const Color color53b3ff = Color(0xff53B3FF);
  static const Color color15A2FF = Color(0xff15A2FF);

  static const Color color644519 = Color(0xff644519);

  static const Color colorB78641 = Color(0xffB78641);

  static const Color newYearColor = Color(0xffe91f40);

  //少量按钮
  static const Color colorF8931f = Color(0xfff8931f);

  static const Color colorFFCF31 = Color(0xffffcf31);
  static const Color colorFFd9a3 = Color(0xffffd9a3);
  static const Color colorFfa800 = Color(0xffFfa800);
  static const Color colorFccb19 = Color(0xfffccb19);
  static const Color colorD300= Color(0xffffd300);
  static const Color colorF7d3= Color(0xfffff7d3);
  static const Color colorFa861e= Color(0xffFa861e);

  static const Color colorEFE6DB = Color(0xffefe6db);
  static const Color colorFBFAFA = Color(0xfffbfafa);
  static const Color color5B = Color(0xff5b5b5b);
  static const Color colorF5d8 = Color(0xfffff5d8);

  // static const Color dividerColor = Color(0x8Aeeeff0);
  static const Color dividerColor = Color(0xffeeeeee);

//  static const Color grayF8f9fc = Color(0xffF8F9FC);
  static const Color grayF5f6f9 = Color(0xffF5f6f9);

  static const Color black_33 = Color(0xFF333333);

  static const Color gray66 = Color(0xFF666666);
  static const Color grayBB = Color(0xFFbbbbbb);
  static const Color gray5B = Color(0xFF5b5b5b);
  static const Color gray8e = Color(0xff8e8e8e);
  static const Color gray99 = Color(0xFF999999);
  static const Color grayF2 = Color(0xFFf2f2f2);
  static const Color grayEff0f6 = Color(0xFFEff0f6);
  static const Color grayF8f9fe = Color(0xFFf8f9fe);
  static const Color grayF1f2f7 = Color(0xFFf1f2f7);

  static const Color grayC9C9CA = Color(0xffc9c9ca);

  static const Color grayD7d8da = Color(0xffd7d8da);
  static const Color grayEE = Color(0xffeeeeee);

  // static const Color grayF9fafe = Color(0xffF9fafe);
  static const Color bgColor = Color(0xffF9fafe);

  static const Color colorFDC914 = Color(0xffFDC914);
  static const Color colorE8F3FE = Color(0xffE8F3FE);
  static const Color color0154F8 = Color(0xff0154F8);
  static const Color color006FE1 = Color(0xff006FE1);
  static const Color colorFf5400 = Color(0xffff6400);
  static const Color color57b1ff = Color(0xff57b1ff);
  static const Color color267be3 = Color(0xff267be3);

  static const Color colorC17105 = Color(0xffc17105);
  static const Color gold = Color(0xffc17105);

  static const Color colorD5a668=Color(0xffd5a668);
  static const Color colorAF7A42=Color(0xffAF7A42);

  static const Color colorE4f3d9=Color(0xffE4f3d9);
  static const Color color4aac00=Color(0xff4aac00);

}

Gradient get blueGradient => LinearGradient(
    colors: [Color(0xff0154fc), Color(0xff1a8bff), Color(0xff00ccff)],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft);

Gradient get orangeGradient => LinearGradient(
    colors: [Color(0xffFE6000), Color(0xffFF6A00), Color(0xffFF941D)],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft);

Gradient get goldGradient => LinearGradient(
    colors: [AppColors.gold, Color(0xffcb9348), Color(0xffead2a3)],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft);

class AppSizes {
  static const double avatar = 56;

  static const double iconNormal = 24;

  static const double iconBig = 40;
  static const double big = 16;
  static const double normal = 14;
  static const double small = 12;
}
