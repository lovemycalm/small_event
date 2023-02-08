import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:monthsign/models/task_info.dart';
import 'package:monthsign/pages/add_sign_task.dart';
import 'package:monthsign/pages/sign_record_page.dart';
import 'package:monthsign/utils/db_utils.dart';
import 'package:monthsign/utils/route.dart';
import 'package:monthsign/utils/widget_creator.dart';

void main() {
//  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));

  Future.delayed(Duration(seconds: 1), () {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '小事记',
      theme: ThemeData(
          primaryColor: Color(0xff1e1e1e),
          primarySwatch: Colors.blue,
          buttonColor: Color(0xff1e1e1e),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xff1e1e1e),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle.light)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double imageSize = 0;

  List<TaskInfo> taskInfoList = [];

  @override
  void initState() {
    super.initState();
    _refreshInfo();
  }

  void _refreshInfo() async {
    taskInfoList = await DbHelper.getAllTask();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget cardContainer = Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: ListView.builder(
        itemBuilder: (c, i) {
          return _buildTaskItem(taskInfoList[i]);
        },
        itemCount: taskInfoList.length,
      ),
    );

    var mainWidget = Scaffold(
      appBar: AppBar(
        title: Text('小事记'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.storage),
            onPressed: () {
              ARouter.pushByWidget(context, SignRecordPage());
            },
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: cardContainer,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          ARouter.pushByWidget(context, AddSignTask()).then((value) {
            if (value != null) {
              _refreshInfo();
            }
          });
        },
        tooltip: '添加小事',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    return mainWidget;
  }

  Widget _buildTaskItem(TaskInfo taskInfo) {
    Widget child = Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 25),
          alignment: Alignment.centerLeft,
          child: Text(
            taskInfo.taskName!,
            style: TextStyle(fontSize: 25, color: Colors.white,shadows: [
              Shadow(color: Colors.black,blurRadius: 1,),
              Shadow(color: Colors.cyanAccent,blurRadius: 2)
            ],fontWeight: FontWeight.w500),
          ),
        ).toClickableWidget(onTap: () {
          DbHelper.addTaskSignRecord(SignTaskRecord.create(taskInfo.id!))
              .then((value) {
            Fluttertoast.showToast(msg: '记录成功！');
          });
        }).toExpandedWidget(),
        Column(
          children: [
            TextButton(
              child: Text('查看记录'),
              onPressed: () {
                ARouter.pushByWidget(context, SignRecordPage(eventId: taskInfo.id!,));
              },
            ).toExpandedWidget(),
            TextButton(
              child: Text('删除事件'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: Text('确定要删除该打卡吗？'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('确定删除'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              DbHelper.deleteTask(taskInfo.id!).then((value) {
                                Fluttertoast.showToast(msg: '删除成功！');
                                setState(() {
                                  taskInfoList.remove(taskInfo);
                                });
                              });
                            },
                          )
                        ],
                      );
                    });
              },
            ).toExpandedWidget(),
          ],
        )
      ],
    );

    return SizedBox(
      height: 80,
      child: Card(
        color: Color(taskInfo.colorValue!),
        child: child.toPaddingWidget(EdgeInsets.symmetric(horizontal: 15,vertical: 2)),
      ),
    );

    // return Container(
    //   alignment: Alignment.center,
    //   width: double.infinity,
    //   height: 80,
    //   decoration: BoxDecoration(
    //       color: Color(taskInfo.colorValue!),
    //       borderRadius: BorderRadius.circular(10)),
    //   child: child,
    // );
  }
}
