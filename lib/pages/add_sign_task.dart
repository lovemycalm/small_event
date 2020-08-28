import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monthsign/models/task_info.dart';
import 'package:monthsign/pages/sign_record_page.dart';
import 'package:monthsign/utils/db_utils.dart';
import 'package:monthsign/utils/mock_data_test.dart';
import 'package:monthsign/utils/route.dart';

class AddSignTask extends StatefulWidget {
  @override
  _AddSignTaskState createState() => _AddSignTaskState();
}

class _AddSignTaskState extends State<AddSignTask> {
  Color taskColor;

//  TimeOfDay startTime;
//  TimeOfDay endTime;

  TextEditingController taskNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    taskColor = MockData.getRandomColor();
  }

  @override
  Widget build(BuildContext context) {
    Function chooseColor = () {
      showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 150),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            Color tmpColor;
            return Center(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleColorPicker(
                      size: Size(250, 250),
                      initialColor: taskColor,
                      onChanged: (c) {
                        tmpColor = c;
                      },
                    ),
                    Container(
                      width: 250,
                      padding: EdgeInsets.only(top: 10),
                      child: FlatButton(
                        color: Colors.blue,
                        child: Text(
                          '选择该颜色',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          taskColor = tmpColor;
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('添加打卡任务'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: taskNameController,
                  decoration: InputDecoration(
//                  icon: Icon(Icons.speaker_notes),
                      labelText: '输入任务名称',
                      helperText: '需要显示在打卡按钮上的任务'),
                ),
                InkWell(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('选择颜色'),
                        Container(
                          width: 80,
                          height: 30,
                          color: taskColor,
                        )
                      ],
                    ),
                  ),
                  onTap: chooseColor,
                ),
//                Padding(
//                  padding: EdgeInsets.symmetric(vertical: 15),
//                  child: Row(
//                    children: <Widget>[
//                      Text('开始时间:  '),
//                      Text(startTime != null
//                          ? startTime.format(context)
//                          : '无限制'),
//                      Expanded(
//                        flex: 1,
//                        child: Container(),
//                      ),
//                      FlatButton(
//                        color: Colors.blue,
//                        child: Text(
//                          '选择',
//                          style: TextStyle(color: Colors.white),
//                        ),
//                        onPressed: () {
//                          showTimePicker(
//                                  context: context,
//                                  initialTime: startTime ??
//                                      TimeOfDay(hour: 0, minute: 0))
//                              .then((value) {
//                            setState(() {
//                              startTime = value;
//                            });
//                          });
//                        },
//                      ),
//                    ],
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.symmetric(vertical: 15),
//                  child: Row(
//                    children: <Widget>[
//                      Text('结束时间:  '),
//                      Text(endTime != null ? endTime.format(context) : '无限制'),
//                      Expanded(
//                        flex: 1,
//                        child: Container(),
//                      ),
//                      FlatButton(
//                        color: Colors.blue,
//                        child: Text(
//                          '选择',
//                          style: TextStyle(color: Colors.white),
//                        ),
//                        onPressed: () {
//                          showTimePicker(
//                                  context: context,
//                                  initialTime:
//                                      endTime ?? TimeOfDay(hour: 0, minute: 0))
//                              .then((value) {
//                            setState(() {
//                              endTime = value;
//                            });
//                          });
//                        },
//                      ),
//                    ],
//                  ),
//                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: FlatButton(
                    color: Colors.blue,
                    child: Text(
                      '确定',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      await DbHelper.addTaskInfo(TaskInfo()
                        ..taskName = taskNameController.text
                        ..colorValue = taskColor.value);
                      Fluttertoast.showToast(msg: '添加成功');
                      Navigator.pop(context,'success');
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}

Future showMyDialog(BuildContext context, Widget dialogContent) {
  return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return dialogContent;
      });
}
