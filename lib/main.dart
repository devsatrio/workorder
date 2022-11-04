import 'package:flutter/material.dart';
import 'package:workorder/models/detail_work_arg.dart';
import 'package:workorder/view/all_todo.dart';
import 'package:workorder/view/create.dart';
import 'package:workorder/view/detail.dart';
import 'package:workorder/view/edit.dart';
import 'package:workorder/view/home.dart';
import 'package:workorder/view/login.dart';
import 'package:flutter/services.dart';
import 'package:workorder/view/today_todo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(WorkOrderApp());
}

class WorkOrderApp extends StatefulWidget {
  const WorkOrderApp({Key? key}) : super(key: key);

  @override
  State<WorkOrderApp> createState() => _WorkOrderAppState();
}

class _WorkOrderAppState extends State<WorkOrderApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/edittodo') {
          final final_args = settings.arguments as DetailWorkArg;
          return MaterialPageRoute(
            builder: (context) {
              return EditPage(arg: final_args);
            },
          );
        }},
      debugShowCheckedModeBanner: false,
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => HomePage(),
        '/todaytodo':(context) => TodayTodo(),
        '/loginpage': (context) => LoginPage(),
        '/createpage': (context) => CreatePage(),
        '/detailtodo': (context) => detailTodo(),
        '/alltodo': (context) => AllTodo(),
        // '/edittodo':(context) => EditPage(),
      },
    );
  }
}
