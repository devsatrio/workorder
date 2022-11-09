import 'package:flutter/material.dart';
import 'package:workorder/models/all_todo_data.dart';
import 'package:workorder/models/detail_work_arg.dart';

import '../constants/appcolors.dart';
import '../services/todo_services.dart';

class AllTodo extends StatefulWidget {
  const AllTodo({Key? key}) : super(key: key);

  @override
  State<AllTodo> createState() => _AllTodoState();
}

class _AllTodoState extends State<AllTodo> {
  bool showProgress = false;
  bool lastPageData = false;
  late Future getdatawork;
  AllTodoData finaldatawork = new AllTodoData();
  TextEditingController search_conn = TextEditingController();
  List<Data>? listdata = [];
  int page_num = 1;
  String cari_val = '';
  final listviewcontroller = ScrollController();

  @override
  void initState() {
    get_data();
    listviewcontroller.addListener(() {
      if (listviewcontroller.position.maxScrollExtent ==
          listviewcontroller.offset) {
        get_data();
      }
    });
    super.initState();
  }

  Future get_data() async {
    getdatawork = TodoServices().getAllDataOrder(page_num, cari_val);
    getdatawork.then((value) {
      finaldatawork = value;
      if (finaldatawork.nextPageUrl == null) {
        setState(() {
          lastPageData = true;
        });
      }
      setState(() {
        listdata?.addAll(finaldatawork.data!.toList());
        page_num = finaldatawork.currentPage!.toInt() + 1;
      });
    });
  }

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
                                  setState(() {
                                    listdata!.clear();
                                    page_num = 1;
                                  });
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
                  const SizedBox(height: 15),
                  TextFormField(
                    onEditingComplete: () {
                      setState(() {
                        listdata!.clear();
                        cari_val = search_conn.text;
                        page_num = 1;
                        lastPageData = false;
                      });
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      get_data();
                    },
                    controller: search_conn,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: APP_COLOR,
                          ),
                          onPressed: () {
                            search_conn.text = '';
                            setState(() {
                              listdata!.clear();
                              cari_val = search_conn.text;
                              page_num = 1;
                              lastPageData = false;
                            });
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            get_data();
                          }),
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: APP_COLOR, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: APP_COLOR, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      hintText: 'Search data',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: APP_COLOR,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Flexible(
                    child: showProgress
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: APP_COLOR,
                          ))
                        : ListView.builder(
                            controller: listviewcontroller,
                            itemCount: listdata!.length + 1,
                            itemBuilder: (context, index) {
                              if (index < listdata!.length) {
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
                                                backgroundColor: listdata![
                                                                index]
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
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    listdata![index]
                                                        .permasalahan
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Text(listdata![index]
                                                    .tglOrder
                                                    .toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                        PopupMenuButton(
                                          child: const Center(
                                            child:
                                                Icon(Icons.more_vert_outlined),
                                          ),
                                          onSelected: (value) {
                                            if (value == 'delete') {
                                              showDeletePopup(
                                                  context,
                                                  listdata![index]
                                                      .idwo
                                                      .toString());
                                            } else if (value == 'detail') {
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
                              } else {
                                if (lastPageData) {
                                  if (finaldatawork.currentPage!.toInt() > 2) {
                                    return const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 32),
                                      child: Center(
                                          child: Text(
                                        'No more data...',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                    );
                                  } else {
                                    return SizedBox(height: 1);
                                  }
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: APP_COLOR,
                                      ),
                                    ),
                                  );
                                }
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
