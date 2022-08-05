import 'dart:io';

import 'package:flutter/material.dart';
import 'package:workorder/constants/appcolors.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> showLogoutPopup(context) async {
  final prefs = await SharedPreferences.getInstance();
  return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Do you want to Logout ?"),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              final success = await prefs.clear();
                              Navigator.of(context).pushNamed('/loginpage');
                            },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(APP_COLOR)),
                            child: Text("Yes"),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            print('no selected');
                            Navigator.of(context).pop();
                          },
                          child:
                              Text("No", style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            );
          }) ??
      false;
}
