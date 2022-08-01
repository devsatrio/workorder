import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  void check_if_already_login() async {
    final logindata = await SharedPreferences.getInstance();
    var newuser = (logindata.getBool('login') ?? true);
    print(logindata.getBool('login'));
    if (logindata.getBool('login')==null ||logindata.getBool('login')==false) {
      Navigator.of(context).pushNamed('/loginpage');
    };
  }
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}