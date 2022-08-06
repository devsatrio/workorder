import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workorder/constants/appcolors.dart';
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
  void check_if_already_login() async {
    final logindata = await SharedPreferences.getInstance();
    if (logindata.getBool('login') == null ||
      logindata.getBool('login') == false) {
      Navigator.of(context).pushNamed('/loginpage');
    }else{
      setState(() {
      logindata_username = logindata.getString('username');
    });
    }
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
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
        body: Stack(
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
                    onTap: (){
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
                        child: Text('Welcome Back $logindata_username To')),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.topRight,
                    child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'EDP Work Order V.1',
                          style: TextStyle(fontSize: 25, color: APP_COLOR),
                        )),
                  ),
                  SizedBox(height: 10.0),
                  MenuSatu(),
                  SizedBox(height: 5.0),
                  MenuDua(),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class MenuSatu extends StatelessWidget {
  const MenuSatu({
    Key? key,
  }) : super(key: key);

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
                Icons.directions_run,
                color: Colors.white,
                size: 52.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "To Do List",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "2 To Do",
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

class MenuDua extends StatelessWidget {
  const MenuDua({
    Key? key,
  }) : super(key: key);

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
                Icons.inventory,
                color: Colors.white,
                size: 52.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "All To Do",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "2 To Do",
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
