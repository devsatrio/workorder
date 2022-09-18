import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workorder/constants/appcolors.dart';
import 'package:workorder/models/dashboard_data.dart';
import 'package:workorder/services/todo_services.dart';
import 'package:workorder/view/logout_popup.dart';

import 'exit_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names
  String? logindata_username;
  late Future datadashboardtoday;
  late DataDashboard dataDashboard;
  String order_hari_ini = '0';
  String order_selesai_hari_ini = '0';

  void check_if_already_login() async {
    final logindata = await SharedPreferences.getInstance();
    if (logindata.getBool('login') == null ||
        logindata.getBool('login') == false) {
      Navigator.of(context).pushNamed('/loginpage');
    } else {
      setState(() {
        logindata_username = logindata.getString('username');
      });
    }
  }

  void get_data_dashboard() async {
    datadashboardtoday = TodoServices().getDashboard();
    datadashboardtoday.then((value) {
      if (value == null) {
        Alert(
          context: context,
          type: AlertType.error,
          style: const AlertStyle(
            isCloseButton: false,
          ),
          title: "Oops",
          desc: "Gagal Mengambil Data",
          buttons: [
            DialogButton(
              color: APP_COLOR,
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ).show();
      } else {
        dataDashboard = value;
        setState(() {
          order_hari_ini = dataDashboard.orderToday.toString();
          order_selesai_hari_ini = dataDashboard.orderFinishToday.toString();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
    get_data_dashboard();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/createpage');
            },
            backgroundColor: APP_COLOR,
            child: const Icon(Icons.add),
          ),
          body: RefreshIndicator(
            color: APP_COLOR,
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                () {
                  get_data_dashboard();
                },
              );
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.topCenter,
                          image: AssetImage('assets/images/header.png')),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: sized_box_for_whitespace
                          InkWell(
                            onTap: () {
                              showLogoutPopup(context);
                            },
                            child: Container(
                              height: 64,
                              child: const Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(height: 55.0),
                          Container(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Text(
                                    'Welcome Back $logindata_username To')),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            alignment: Alignment.topRight,
                            child: const Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Text(
                                  'EDP Work Order V.1',
                                  style:
                                      TextStyle(fontSize: 25, color: APP_COLOR),
                                )),
                          ),
                          SizedBox(height: 10.0),
                          MenuDua(
                              order_selesai_hari_ini: order_selesai_hari_ini),
                          SizedBox(height: 5.0),
                          MenuSatu(order_hari_ini: order_hari_ini),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class MenuDua extends StatelessWidget {
  const MenuDua({
    Key? key,
    required this.order_selesai_hari_ini,
  }) : super(key: key);

  final String order_selesai_hari_ini;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: APP_COLOR,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
          child: Row(
            children: [
              const Icon(
                Icons.mood,
                color: Colors.white,
                size: 52.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Finished To Do Today",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "$order_selesai_hari_ini To Do",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuSatu extends StatelessWidget {
  const MenuSatu({
    Key? key,
    required this.order_hari_ini,
  }) : super(key: key);

  final String order_hari_ini;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/todaytodo');
      },
      child: SizedBox(
        child: Card(
          color: APP_COLOR,
          elevation: 2.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
            child: Row(
              children: [
                const Icon(
                  Icons.directions_run,
                  color: Colors.white,
                  size: 52.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today To Do List",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '$order_hari_ini To Do',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w100),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
