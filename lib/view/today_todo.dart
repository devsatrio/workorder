import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:workorder/constants/appcolors.dart';
import 'package:workorder/models/detail_work_arg.dart';
import 'package:workorder/models/work_order_data.dart';
import 'package:workorder/services/todo_services.dart';

class TodayTodo extends StatefulWidget {
  const TodayTodo({Key? key}) : super(key: key);

  @override
  State<TodayTodo> createState() => _TodayTodoState();
}

class _TodayTodoState extends State<TodayTodo> {
  bool showProgress = true;
  late Future getdatawork;
  data_work_order finaldatawork = new data_work_order();
  List<Data>? listdata = [];

  Future<bool> showDeletePopup(context, String idwo) async {
    return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SizedBox(
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Delete Data ?"),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                showProgress = true;
                                TodoServices()
                                    .DeleteTodoAct(idwo)
                                    .then((value) {
                                  showProgress = false;
                                  get_data();
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(APP_COLOR)),
                              child: const Text("Yes"),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No",
                                style: TextStyle(color: Colors.black)),
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

  void get_data() async {
    getdatawork = TodoServices().getTodayOrder();
    getdatawork.then((value) {
      setState(() {
        finaldatawork = value;
        listdata = finaldatawork.data;
        showProgress = false;
      });
    });
  }

  @override
  void initState() {
    get_data();
    super.initState();
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
                        child: Text("See what to do today")),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.topRight,
                    child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'Today To Do',
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
                            itemCount: listdata?.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: CircleAvatar(
                                              backgroundColor: listdata![index]
                                                          .hasil
                                                          .toString() ==
                                                      'selesai'
                                                  ? Colors.green
                                                  : listdata![index]
                                                              .hasil
                                                              .toString() ==
                                                          'belum'
                                                      ? Colors.red
                                                      : Colors.blue,
                                              radius: 25,
                                              child: listdata![index]
                                                          .hasil
                                                          .toString() ==
                                                      'selesai'
                                                  ? Icon(Icons.done)
                                                  : listdata![index]
                                                              .hasil
                                                              .toString() ==
                                                          'belum'
                                                      ? Icon(Icons.close)
                                                      : Icon(Icons.ac_unit),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                listdata![index]
                                                    .unitOrder
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: APP_COLOR,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(listdata![index]
                                                  .namaBarang
                                                  .toString()),
                                              Text(listdata![index]
                                                  .permasalahan
                                                  .toString()),
                                              Text("Tgl Order : " +
                                                  listdata![index]
                                                      .tglOrder
                                                      .toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                      PopupMenuButton(
                                        child: const Center(
                                          child: Icon(Icons.more_vert_outlined),
                                        ),
                                        onSelected: (value) {
                                          if (value == 'detail') {
                                            Navigator.pushNamed(
                                              context,
                                              '/detailtodo',
                                              arguments: DetailWorkArg(
                                                  listdata![index]
                                                      .idwo
                                                      .toString(),
                                                  listdata![index]
                                                      .idUnit
                                                      .toString(),
                                                  listdata![index]
                                                      .tglOrder
                                                      .toString(),
                                                  listdata![index]
                                                      .unitOrder
                                                      .toString(),
                                                  listdata![index]
                                                      .tujuan
                                                      .toString(),
                                                  listdata![index]
                                                      .kategori
                                                      .toString(),
                                                  listdata![index]
                                                      .jenis
                                                      .toString(),
                                                  listdata![index]
                                                      .namaBarang
                                                      .toString(),
                                                  listdata![index]
                                                      .detailBarang
                                                      .toString(),
                                                  listdata![index]
                                                      .permasalahan
                                                      .toString(),
                                                  listdata![index]
                                                      .status
                                                      .toString(),
                                                  listdata![index]
                                                      .tglExecute
                                                      .toString(),
                                                  listdata![index]
                                                      .pelaksana1
                                                      .toString(),
                                                  listdata![index]
                                                      .pelaksana2
                                                      .toString(),
                                                  listdata![index]
                                                      .pelaksana3
                                                      .toString(),
                                                  listdata![index]
                                                      .pelaksana4
                                                      .toString(),
                                                  listdata![index]
                                                      .tindakan
                                                      .toString(),
                                                  listdata![index]
                                                      .hasil
                                                      .toString(),
                                                  listdata![index]
                                                      .tglFinish
                                                      .toString(),
                                                  listdata![index]
                                                      .catatanPetugas
                                                      .toString(),
                                                  listdata![index]
                                                      .tglIn
                                                      .toString(),
                                                  listdata![index]
                                                      .msg
                                                      .toString()),
                                            );
                                          } else if (value == 'delete') {
                                            showDeletePopup(
                                                context,
                                                listdata![index]
                                                    .idwo
                                                    .toString());
                                          } else if (value == 'edit') {
                                            Navigator.pushNamed(
                                              context,
                                              '/edittodo',
                                              arguments: DetailWorkArg(
                                                  listdata![index]
                                                      .idwo
                                                      .toString(),
                                                  listdata![index]
                                                      .idUnit
                                                      .toString(),
                                                  listdata![index]
                                                      .tglOrder
                                                      .toString(),
                                                  listdata![index]
                                                      .unitOrder
                                                      .toString(),
                                                  listdata![index]
                                                      .tujuan
                                                      .toString(),
                                                  listdata![index]
                                                      .kategori
                                                      .toString(),
                                                  listdata![index]
                                                      .jenis
                                                      .toString(),
                                                  listdata![index]
                                                      .namaBarang
                                                      .toString(),
                                                  listdata![index]
                                                      .detailBarang
                                                      .toString(),
                                                  listdata![index]
                                                      .permasalahan
                                                      .toString(),
                                                  listdata![index]
                                                      .status
                                                      .toString(),
                                                  listdata![index]
                                                      .tglExecute
                                                      .toString(),
                                                  listdata![index]
                                                      .pelaksana1
                                                      .toString(),
                                                  listdata![index]
                                                      .pelaksana2
                                                      .toString(),
                                                  listdata![index]
                                                      .pelaksana3
                                                      .toString(),
                                                  listdata![index]
                                                      .pelaksana4
                                                      .toString(),
                                                  listdata![index]
                                                      .tindakan
                                                      .toString(),
                                                  listdata![index]
                                                      .hasil
                                                      .toString(),
                                                  listdata![index]
                                                      .tglFinish
                                                      .toString(),
                                                  listdata![index]
                                                      .catatanPetugas
                                                      .toString(),
                                                  listdata![index]
                                                      .tglIn
                                                      .toString(),
                                                  listdata![index]
                                                      .msg
                                                      .toString()),
                                            );
                                          }
                                        },
                                        itemBuilder: (context) => [
                                          const PopupMenuItem(
                                            value: 'detail',
                                            child: Text('Detail'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'edit',
                                            child: Text('Edit'),
                                          ),
                                          const PopupMenuItem(
                                            value: 'delete',
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
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
