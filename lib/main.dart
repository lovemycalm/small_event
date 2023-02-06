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
import 'package:monthsign/widgets/common_widgets.dart';
import 'package:tapped/tapped.dart';

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
    List<Widget> children = [];

//    children.add(FlatButton(
//      child: Text('刷新'),
//      onPressed: () {
//        _refreshInfo();
//      },
//    ));

    taskInfoList.forEach((element) {
      children.add(buildTaskButton(element));
    });

    Widget cardContainer = Container(
      padding: EdgeInsets.all(15),
      child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: children),
    );

//    SingleChildScrollView(
//      child: Column(
//        children: children,
//      ),
//    )

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

  Widget buildTaskButton(TaskInfo taskInfo) {
    return Tapped(
      onTap: () {
        DbHelper.addTaskSignRecord(SignTaskRecord.create(taskInfo.id!))
            .then((value) {
          Fluttertoast.showToast(msg: '打卡成功！');
        });
      },
      onLongTap: () {
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
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Color(taskInfo.colorValue!)),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(
                taskInfo.taskName!,
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Positioned(
              child: Align(
                child:
                Text(
                  '点击记录一下',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                alignment: Alignment.bottomCenter,
              ),
              bottom: 15,
              left: 0,right: 0,
            )
          ],
        ),
      ),
    );
  }
}
