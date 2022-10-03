import 'package:flutter/material.dart';

class detailTodo extends StatefulWidget {
  const detailTodo({Key? key}) : super(key: key);

  @override
  State<detailTodo> createState() => _detailTodoState();
}

class _detailTodoState extends State<detailTodo> {
  
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      body: Center(
        child: Text(args.title),
      ),
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}