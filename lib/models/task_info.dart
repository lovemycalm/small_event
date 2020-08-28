import 'package:flutter/cupertino.dart';

class TaskInfo {
  int id;
  String taskName;
  int colorValue;
}

class SignTaskRecord {
  SignTaskRecord.create(int taskId) : taskId = taskId;
  SignTaskRecord();

  int recordId;
  int taskId;
  int signTime;


  String taskName;
  int colorValue;
}
