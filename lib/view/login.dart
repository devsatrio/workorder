import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:workorder/constants/appcolors.dart';
import 'package:workorder/view/exit_popup.dart';
import 'package:workorder/services/login_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcoontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/login.png', height: 250),
              Text('EDP Work Order V.1'),
              TextFormField(
                controller: usernamecontroller,
                decoration: InputDecoration(labelText: 'Input Username'),
              ),
              TextFormField(
                controller: passwordcoontroller,
                decoration: InputDecoration(labelText: 'Input Password'),
              ),
              SizedBox(height: 20.0),
              InkWell(
                onTap: () {
                  LoginServices()
                      .loginAct(
                          usernamecontroller.text, passwordcoontroller.text)
                      .then((value) {
                    setState(() {
                      if (value) {
                        Alert(
                                context: context,
                                title: "Info",
                                desc: "Login Berhasil")
                            .show();
                        Navigator.of(context).pushNamed('/homepage');
                      } else {
                        Alert(
                                context: context,
                                type: AlertType.error,
                                title: "Warning",
                                desc: "Login Gagal")
                            .show();
                      }
                    });
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: APP_COLOR,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
