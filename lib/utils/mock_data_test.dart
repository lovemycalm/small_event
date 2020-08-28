import 'dart:math';

import 'package:flutter/cupertino.dart';


class MockData {
  static var _picUrl = [
    "http://attach.bbs.miui.com/forum/201305/24/123936nq3qmi7a3qjx2o3i.jpg",
    "http://desk-fd.zol-img.com.cn/t_s960x600c5/g5/M00/07/0E/ChMkJ1Y5rC-IWBETAAP0wtonFAMAAEfIgFhv7cAA_Ta580.jpg",
    "http://t7.baidu.com/it/u=3204887199,3790688592&fm=79&app=86&f=JPEG?w=4610&h=2968",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590494913709&di=b429417e8ceac6beeb91a64785ef140a&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D1191830543%2C2058173977%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D1920",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590494913708&di=75b9c96b9923fce4fbbf89601a94ba63&imgtype=0&src=http%3A%2F%2Ft7.baidu.com%2Fit%2Fu%3D2336214222%2C3541748819%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590494973771&di=84b4a9d79215086cb26e3452065adf3a&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1857071332%2C471626517%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D800"
  ];

  //https://picsum.photos/200/500
  static String getPicUrl() {
//    return _picUrl[Random.secure().nextInt(_picUrl.length)];
    var random = Random.secure();
    return "https://picsum.photos/${random.nextInt(300) + 200}/${random.nextInt(500) + 200}";
  }

  static String _testText =
      '请从下方标签中选择感兴趣的享受更好的服务暂未找到相关属性设置目前的方法是用包一层就即可以了如果未设置或则会按最小来布局如果设置其中之一另一个则会铺满';

  static String getRandomText() {
    Random random = Random.secure();
    int textLength = random.nextInt(4) + 1;
    String string = '';
    for (int i = 0; i < textLength; i++) {
      int startIndex = random.nextInt(_testText.length);
      string += _testText.substring(startIndex, startIndex + 1);
    }
    return string;
  }

  static Color getRandomColor(){
    Random random = Random.secure();
    return Color.fromARGB(255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }

  static var videoList = [
    "http://artchainglobal.oss-cn-shanghai.aliyuncs.com/resource/1592810212111073.mp4",
    "http://artchainglobal.oss-cn-shanghai.aliyuncs.com/resource/1592816295613687.mp4"
  ];

  static String getRandomVideoUrl() {
    return videoList[Random.secure().nextInt(videoList.length)];
  }
}
