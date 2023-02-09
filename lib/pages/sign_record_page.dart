import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monthsign/models/task_info.dart';
import 'package:monthsign/utils/db_utils.dart';
import 'package:monthsign/utils/widget_creator.dart';

class SignRecordPage extends StatefulWidget {

  final int eventId;

  const SignRecordPage({Key? key, this.eventId=-1}) : super(key: key);

  @override
  _SignRecordPageState createState() => _SignRecordPageState();
}

class _SignRecordPageState extends State<SignRecordPage> {
  List<SignTaskRecord> recordList = [];
  List<TaskInfo> taskInfoList = [];

  @override
  void initState() {
    super.initState();

    curChosenId=widget.eventId;

    print(DateTime.now().millisecondsSinceEpoch ~/ 1000);

    _getRecordList();
    _getTaskInfo();
  }

  void _getRecordList() {
    int? startTime;

    if (_dateType == 1) {
      DateTime now = DateTime.now();
      startTime =
          DateTime(now.year, now.month, now.day).millisecondsSinceEpoch ~/ 1000;
    }

    DbHelper.getAllTaskRecordInfo(curChosenId, startTime: startTime)
        .then((value) {
      setState(() {
        recordList = value;
      });
    });
  }

  late int curChosenId;

  void _getTaskInfo() async {
    taskInfoList = await DbHelper.getAllTask();
    setState(() {});
  }

  int _dateType = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    return Scaffold(
      appBar: AppBar(
        title: Text('打卡记录(${recordList.length})'),
        actions: actions,
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                createText('日期：', fontSize: 16),
                DropdownButton<int>(
                  items: [
                    DropdownMenuItem(
                      child: createText('只看今天'),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: createText('全部日期'),
                      value: 2,
                    ),
                  ],
                  value: _dateType,
                  onChanged: (value) {
                    setState(() {
                      _dateType = value!;
                      _getRecordList();
                    });
                  },
                ),
                createText('事件：', fontSize: 16)
                    .toPaddingWidget(EdgeInsets.only(left: 20)),
                DropdownButton<int>(
                  items: [
                    for (var e in taskInfoList)
                      DropdownMenuItem(
                        child: createText(e.taskName),
                        value: e.id,
                      ),
                    DropdownMenuItem(
                      child: createText('全部事件'),
                      value: -1,
                    ),
                  ],
                  value: curChosenId,
                  onChanged: (value) {
                    setState(() {
                      curChosenId = value!;
                      _getRecordList();
                    });
                  },
                ),
              ],
            ),
          ),
          ListView.builder(
            itemBuilder: (_, i) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7.5),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(recordList[i].colorValue!)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(recordList[i].taskName!),
                      ),
                    ),
                    Text(formatDate(
                        DateTime.fromMillisecondsSinceEpoch(
                            recordList[i].signTime! * 1000),
                        [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss])),
                  ],
                ),
              );
            },
            itemCount: recordList.length,
          ).toExpandedWidget(),
        ],
      ),
    );
  }
}
