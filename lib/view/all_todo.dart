import 'package:flutter/material.dart';

import '../constants/appcolors.dart';

class AllTodo extends StatefulWidget {
  const AllTodo({Key? key}) : super(key: key);

  @override
  State<AllTodo> createState() => _AllTodoState();
}

class _AllTodoState extends State<AllTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    onTap: () {
                      Navigator.of(context).pushNamed('/homepage');
                    },
                    child: Container(
                      height: 64,
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 55.0),
                  Container(
                    alignment: Alignment.topRight,
                    child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text('View All Data From Past')),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.topRight,
                    child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'All To Do',
                          style: TextStyle(fontSize: 25, color: APP_COLOR),
                        )),
                  ),
                ],
              ),
            ),
          )
          ],
      ),
    );
  }
}
