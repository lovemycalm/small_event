import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monthsign/models/task_info.dart';
import 'package:monthsign/utils/db_utils.dart';
import 'package:monthsign/utils/mock_data_test.dart';

class SignRecordPage extends StatefulWidget {
  @override
  _SignRecordPageState createState() => _SignRecordPageState();
}

class _SignRecordPageState extends State<SignRecordPage> {
  List<SignTaskRecord> recordList = [];
  List<TaskInfo> taskInfoList = [];
  @override
  void initState() {
    super.initState();

    print(DateTime.now().millisecondsSinceEpoch~/1000);

    _getRecordList();
    _getTaskInfo();
  }

  void _getRecordList(){
    DbHelper.getAllTaskRecordInfo(curChosenId).then((value) {
      setState(() {
        recordList = value;
      });
    });
  }

  int curChosenId=-1;

  void _getTaskInfo() async{
    taskInfoList = await DbHelper.getAllTask();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> actions=[];
    if(taskInfoList.isNotEmpty){
      actions.add(PopupMenuButton(
        onSelected: (v){
          print("v:$v");
          curChosenId=v;
          _getRecordList();
        },
        itemBuilder: (_){
          return taskInfoList.map((e){
           return PopupMenuItem(
              value: e.id,
              child: Text(e.taskName),
            );
          }).toList()..add(PopupMenuItem(
            value: -1,
            child: Text('全部打卡'),
          ));
        },
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('打卡记录'),
        actions: actions,
      ),
      body: ListView.builder(
        itemBuilder: (_, i) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
            child: Row(
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(recordList[i].colorValue)),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(recordList[i].taskName),
                  ),
                ),
                Text(formatDate(
                    DateTime.fromMillisecondsSinceEpoch(
                        recordList[i].signTime * 1000),
                    [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss])),
              ],
            ),
          );
        },
        itemCount: recordList.length,
      ),
    );
  }
}
