import 'package:flutter/material.dart';

class AllTodo extends StatefulWidget {
  const AllTodo({Key? key}) : super(key: key);

  @override
  State<AllTodo> createState() => _AllTodoState();
}

class _AllTodoState extends State<AllTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('All Todo')),
    );
  }
}
