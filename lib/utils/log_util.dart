import 'package:flutter/foundation.dart';

class Log {
  Log._();

  static void look(dynamic msg) {
    if (!kReleaseMode) {
      if (msg is Error) {
        print('----------------Error START----------------');
        print('####### ERROR_MSG => $msg');
        print(msg.stackTrace);
        print('----------------Error END----------------');
      } else {
        print('----------------LOOK----------------> $msg');
      }
    }
  }

  static void logHttpInfo(String info){
      look(info);
  }

  static Map<String, int> timeTagMap = {};

  static void startLogTime(String tag) {
    timeTagMap[tag] = DateTime.now().millisecondsSinceEpoch;
    look('startLogTime:$tag');
  }

  static void stopLogTime(String tag) {
    var time = timeTagMap[tag];
    if (time == null) {
      look('stopLogTime,no $tag start,please check!!!');
    } else {
      int costTime = DateTime.now().millisecondsSinceEpoch - time;
      look('stopLogTime,do $tag costTime:$costTime');
      timeTagMap.remove(tag);
    }
  }
}
