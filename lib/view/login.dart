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
  bool showProgress = false;
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcoontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _LoginImg(),
              _InputUsername(usernamecontroller: usernamecontroller),
              const _Jarak(),
              _InputPassword(passwordcoontroller: passwordcoontroller),
              const _JarakDua(),
              InkWell(
                onTap: () {
                  setState(() {
                    showProgress = true;
                  });
                  LoginServices()
                      .loginAct(
                          usernamecontroller.text, passwordcoontroller.text)
                      .then((value) {
                    setState(() {
                      if (value) {
                        Alert(
                                style: const AlertStyle(
                                  isCloseButton: false,
                                ),
                                context: context,
                                title: "Info",
                                desc: "Login Berhasil")
                            .show();
                        Navigator.of(context).pushNamed('/homepage');
                      } else {
                        Alert(
                          context: context,
                          type: AlertType.error,
                          style: const AlertStyle(
                            isCloseButton: false,
                          ),
                          title: "Oops",
                          desc: "Login Gagal",
                          buttons: [
                            DialogButton(
                              color: APP_COLOR,
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        ).show();
                      }
                      showProgress = false;
                    });
                  });
                },
                child: showProgress
                    ? const CircularProgressIndicator(
                        color: APP_COLOR,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: APP_COLOR,
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ),
              const _JarakDua(),
              const Text('EDP Work Order V.1',
                  style: TextStyle(color: APP_COLOR)),
            ],
          ),
        ),
      ),
    );
  }
}

class _JarakDua extends StatelessWidget {
  const _JarakDua({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20.0);
  }
}

class _Jarak extends StatelessWidget {
  const _Jarak({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 8.0);
  }
}

class _InputPassword extends StatelessWidget {
  const _InputPassword({
    Key? key,
    required this.passwordcoontroller,
  }) : super(key: key);

  final TextEditingController passwordcoontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordcoontroller,
      decoration: const InputDecoration(
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: APP_COLOR)),
        hintText: 'Password',
        prefixIcon: Icon(
          Icons.lock,
          color: APP_COLOR,
        ),
      ),
    );
  }
}

class _InputUsername extends StatelessWidget {
  const _InputUsername({
    Key? key,
    required this.usernamecontroller,
  }) : super(key: key);

  final TextEditingController usernamecontroller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: usernamecontroller,
      decoration: const InputDecoration(
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: APP_COLOR)),
        hintText: 'Username',
        prefixIcon: Icon(
          Icons.perm_identity,
          color: APP_COLOR,
        ),
      ),
    );
  }
}

class _LoginImg extends StatelessWidget {
  const _LoginImg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/login.png', height: 200);
  }
}
