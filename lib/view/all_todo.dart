import 'package:flutter/material.dart';
import 'package:workorder/models/all_todo_data.dart';

import '../constants/appcolors.dart';
import '../services/todo_services.dart';

class AllTodo extends StatefulWidget {
  const AllTodo({Key? key}) : super(key: key);

  @override
  State<AllTodo> createState() => _AllTodoState();
}

class _AllTodoState extends State<AllTodo> {
  bool showProgress = false;
  late Future getdatawork;
  AllTodoData finaldatawork = new AllTodoData();
  List<Data>? listdata = [];
  int page_num = 1;
  final listviewcontroller = ScrollController();

  Future get_data() async {
    getdatawork = TodoServices().getAllDataOrder(page_num);
    getdatawork.then((value) {
      setState(() {
        finaldatawork = value;
        listdata?.addAll(finaldatawork.data!.toList());
        page_num = finaldatawork.currentPage!.toInt() + 1;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    get_data();
    super.initState();
    listviewcontroller.addListener(() {
      if(listviewcontroller.position.maxScrollExtent==listviewcontroller.offset){
        get_data();
      }
    });
  }

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

                  const SizedBox(height: 10),
                  Expanded(
                    child: showProgress
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: APP_COLOR,
                          ))
                        : ListView.builder(
                          controller: listviewcontroller,
                            itemCount: listdata!.length+1,
                            itemBuilder: (context, index) {
                              if (index < listdata!.length) {
                                return Card(
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(listdata![index]
                                          .unitOrder
                                          .toString())),
                                );
                              }else{
                                return Padding(padding: EdgeInsets.symmetric(vertical: 32),child: Center(child: CircularProgressIndicator(),),);
                              }
                            },
                          ),
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
