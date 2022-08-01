import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workorder/view/exit_popup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: Center(child: Text('Login Page')),
      ),
    );
  }
}


