import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:monthsign/models/task_info.dart';
import 'package:monthsign/utils/log_util.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static const String DB_NAME = "data.db";
  static const String TABLE_TASK_NAME = 'task_info';
  static const String TABLE_TASK_RECORD_NAME = 'task_record_info';

  static Future<Database> getDb() async {
    return openDatabase(DB_NAME, version: 1, onCreate: (db, version) async {
      //创建任务表。
      //startTime TEXT, end Time Text   暂不加时间限制了
      await db.execute(
          'CREATE TABLE $TABLE_TASK_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, taskName TEXT, colorValue INTEGER)');
      //创建任务表。
      await db.execute(
          'CREATE TABLE $TABLE_TASK_RECORD_NAME (recordId INTEGER PRIMARY KEY AUTOINCREMENT, taskId INTEGER, signTime INTEGER)');
    });
  }

  static Future addTaskInfo(TaskInfo taskInfo) async {
    getDb().then((value) {
      value.insert(TABLE_TASK_NAME,
          {'taskName': taskInfo.taskName, 'colorValue': taskInfo.colorValue});
    });
  }

  static Future<List<TaskInfo>> getAllTask() async {
    Database database = await getDb();
    var query = await database.query(TABLE_TASK_NAME);
    List<TaskInfo> taskList = [];
    query.forEach((element) {
      taskList.add(TaskInfo()
        ..id = element['id']! as int
        ..colorValue = element['colorValue']! as int
        ..taskName = element['taskName']! as String);
    });
    return Future.value(taskList);
  }

  static Future addTaskSignRecord(SignTaskRecord record) async {
    Database database = await getDb();
    int signTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    // signTime -= 60 * 60 * 24;
    database.insert(TABLE_TASK_RECORD_NAME,
        {'taskId': record.taskId, 'signTime': signTime});
    return Future.value(null);
  }

  static Future deleteTask(int taskId) async {
    Database database = await getDb();
    await database.transaction((txn) async {
      await txn.rawDelete('delete from $TABLE_TASK_NAME where id=$taskId');
      await txn.rawDelete(
          'delete from $TABLE_TASK_RECORD_NAME where taskId=$taskId');
    });
    return Future.value(Void);
  }

  static Future<List<SignTaskRecord>> getAllTaskRecordInfo(int taskId,
      {int? startTime, int? endTime}) async {
    Database database = await getDb();
    String sql;

    String dateCondition = '';
    if (startTime != null) {
      dateCondition += 'and $TABLE_TASK_RECORD_NAME.signTime>=$startTime';
    }
    if (endTime != null) {
      dateCondition += 'and $TABLE_TASK_RECORD_NAME.signTime<$endTime';
    }

    Log.look("startTime:$startTime   dateCondition:$dateCondition");

    if (taskId != -1) {
      sql =
          'select $TABLE_TASK_RECORD_NAME.signTime,$TABLE_TASK_NAME.colorValue,$TABLE_TASK_NAME.taskName from $TABLE_TASK_RECORD_NAME '
          'INNER JOIN $TABLE_TASK_NAME ON $TABLE_TASK_RECORD_NAME.taskId=$TABLE_TASK_NAME.id where $TABLE_TASK_RECORD_NAME.taskId=$taskId $dateCondition order by $TABLE_TASK_RECORD_NAME.signTime desc';
    } else {
      sql =
          'select $TABLE_TASK_RECORD_NAME.signTime,$TABLE_TASK_NAME.colorValue,$TABLE_TASK_NAME.taskName from $TABLE_TASK_RECORD_NAME '
          'INNER JOIN $TABLE_TASK_NAME ON $TABLE_TASK_RECORD_NAME.taskId=$TABLE_TASK_NAME.id ${dateCondition.isNotEmpty ? 'where ${dateCondition.replaceFirst('and', '')}' : ''} order by $TABLE_TASK_RECORD_NAME.signTime desc';
    }
    print('sql:$sql');
    var query = await database.rawQuery(sql);
    List<SignTaskRecord> taskList = [];
    query.forEach((element) {
      taskList.add(SignTaskRecord()
        ..colorValue = element['colorValue']! as int
        ..taskName = element['taskName']! as String
        ..signTime = element['signTime']! as int);
    });
    return Future.value(taskList);
  }

  static void test() async {
    Database database = await getDb();

    String sql =
        'select $TABLE_TASK_RECORD_NAME.signTime,$TABLE_TASK_NAME.colorValue,$TABLE_TASK_NAME.taskName from $TABLE_TASK_RECORD_NAME '
        'INNER JOIN $TABLE_TASK_NAME ON $TABLE_TASK_RECORD_NAME.taskId=$TABLE_TASK_NAME.id';
    print('sql:$sql');
    var list = await database.rawQuery(sql);

    list.forEach((element) {
      print('-----');
      element.forEach((key, value) {
        print('key:$key,value:$value');
      });
    });
  }
}
