import 'package:flutter/material.dart';
import 'package:workorder/constants/appcolors.dart';
import 'package:workorder/models/detail_work_arg.dart';

class detailTodo extends StatefulWidget {
  const detailTodo({Key? key}) : super(key: key);

  @override
  State<detailTodo> createState() => _detailTodoState();
}

class _detailTodoState extends State<detailTodo> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as DetailWorkArg;
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
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 64,
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
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
                    ],
                  ),
                  const SizedBox(height: 55.0),
                  Container(
                    alignment: Alignment.topRight,
                    child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("Detail To Do")),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          args.idwo,
                          style:
                              const TextStyle(fontSize: 25, color: APP_COLOR),
                        )),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                        child: Card(
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide:
                                  const BorderSide(color: APP_COLOR_GREY)),
                          color: APP_COLOR_GREY,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tgl Order',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.tglOrder)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.location_city_rounded,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Unit Order',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.unitOrder)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.location_city_rounded,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Unit Tujuan',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.tujuan)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.category_rounded,
                                        color: APP_COLOR,
                                        size: 30,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Barang',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.namaBarang)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.note_alt_outlined,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Detail Barang',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.detailBarang)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Permasalahan',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.permasalahan)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.group,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Petugas',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Row(
                                          children: [
                                            args.pelaksana1 != ''
                                                ? Text(args.pelaksana1)
                                                : Text(' '),
                                            args.pelaksana2 != ''
                                                ? Text(', ' + args.pelaksana2)
                                                : Text(' '),
                                            args.pelaksana3 != ''
                                                ? Text(', ' + args.pelaksana3)
                                                : Text(' '),
                                            args.pelaksana4 != ''
                                                ? Text(', ' + args.pelaksana4)
                                                : Text(' '),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tindakan',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.tindakan)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.turned_in_rounded,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Status Pengerjaan',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.hasil)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.note_alt_rounded,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Catatan Petugas',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.catatanPetugas)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tgl Pengerjaan',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.tglExecute)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tgl Selesai Pengerjaan',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.tglFinish)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.calendar_today_outlined,
                                        color: APP_COLOR,
                                        size: 25,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Tgl Input Data',
                                          style: TextStyle(
                                              fontSize: 18, color: APP_COLOR),
                                        ),
                                        Text(args.tglIn)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 25.0),
                            ],
                          ),
                        ),
                      ),
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
