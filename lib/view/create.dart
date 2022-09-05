import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:workorder/constants/appcolors.dart';
import 'package:workorder/models/pelaksanan_data.dart';
import 'package:workorder/services/todo_services.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool showProgress = false;
  late Future dataUnit;
  late Future dataBarang;
  late Future dataPelaksana;

  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _items_barang = [];
  List<Object?> _selectedpelaksana = [];
  late List<MultiSelectItem<Object?>> _items_pelaksanan = [];
  final List<Map<String, dynamic>> _items_status = [
    {'value': 'selesai', 'label': 'Selesai'},
    {'value': 'belum', 'label': 'Belum'},
    {'value': 'proses', 'label': 'Proses'},
    {'value': 'pending', 'label': 'Pending'},
  ];

  TextEditingController tgl_order = TextEditingController();
  TextEditingController tgl_pengerjaan = TextEditingController();
  TextEditingController tgl_selesai = TextEditingController();
  TextEditingController con_detail_barang_order = TextEditingController();
  TextEditingController con_permasalahan = TextEditingController();
  TextEditingController con_tindakan = TextEditingController();
  TextEditingController con_catatan_petugas = TextEditingController();

  String? unit_order = '';
  String? unit_tujuan_order = 'UNI.0092-EDP';
  String? barang_order = '';
  String? status_pengerjaan = 'Selesai';

  Future getDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: APP_COLOR, // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    }

    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: APP_COLOR, // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedTime != null) {
      final date_tgl = DateTime(pickedDate.year, pickedDate.month,
          pickedDate.day, pickedTime.hour, pickedTime.minute);
      String formattedDateTime =
          DateFormat('yyyy-MM-dd kk:mm').format(date_tgl);
      setState(() {
        tgl_order.text = formattedDateTime;
      });
    }
  }

  Future getDateTime_dua() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: APP_COLOR, // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    }

    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: APP_COLOR, // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedTime != null) {
      final date_tgl = DateTime(pickedDate.year, pickedDate.month,
          pickedDate.day, pickedTime.hour, pickedTime.minute);
      String formattedDateTime =
          DateFormat('yyyy-MM-dd kk:mm').format(date_tgl);
      setState(() {
        tgl_pengerjaan.text = formattedDateTime;
      });
    }
  }

  Future getDateTime_tiga() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: APP_COLOR, // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    }

    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: APP_COLOR, // <-- SEE HERE
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedTime != null) {
      final date_tgl = DateTime(pickedDate.year, pickedDate.month,
          pickedDate.day, pickedTime.hour, pickedTime.minute);
      String formattedDateTime =
          DateFormat('yyyy-MM-dd kk:mm').format(date_tgl);
      setState(() {
        tgl_selesai.text = formattedDateTime;
      });
    }
  }

  @override
  void initState() {
    dataUnit = TodoServices().getUnit();
    dataBarang = TodoServices().getWorkList();
    dataPelaksana = TodoServices().getPelaksana();

    dataPelaksana.then((value) {
      setState(() {
        _items_pelaksanan = value;
      });
    });

    dataUnit.then((value) {
      setState(() {
        _items = value;
      });
    });

    dataBarang.then((value) {
      setState(() {
        _items_barang = value;
      });
    });

    DateTime now = DateTime.now();
    String newDateNow = DateFormat('yyyy-MM-dd kk:mm').format(now);
    tgl_order.text = newDateNow;
    tgl_pengerjaan.text = newDateNow;
    tgl_selesai.text = newDateNow;
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
                        child: Text('Make new to do data')),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    alignment: Alignment.topRight,
                    child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text(
                          'Add To Do',
                          style: TextStyle(fontSize: 25, color: APP_COLOR),
                        )),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: tgl_order,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'Tgl Order',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.calendar_today_outlined,
                                  color: APP_COLOR,
                                ),
                              ),
                              onTap: getDateTime,
                            ),
                            SelectFormField(
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              initialValue: '',
                              items: _items,
                              onChanged: (val) {
                                setState(() {
                                  unit_order = val;
                                });
                              },
                              onSaved: (val) {
                                setState(() {
                                  unit_order = val;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Unit',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.location_city_rounded,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            SelectFormField(
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              initialValue: 'UNI.0092-EDP',
                              items: _items,
                              onChanged: (val) {
                                setState(() {
                                  unit_tujuan_order = val;
                                });
                              },
                              onSaved: (val) {
                                setState(() {
                                  unit_tujuan_order = val;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Unit Tujuan',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.location_city_rounded,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            SelectFormField(
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              initialValue: '',
                              items: _items_barang,
                              onChanged: (val) {
                                setState(() {
                                  barang_order = val;
                                });
                              },
                              onSaved: (val) {
                                setState(() {
                                  barang_order = val;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Barang',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.category_rounded,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: con_detail_barang_order,
                              decoration: const InputDecoration(
                                labelText: 'Detail Barang',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.note_alt_outlined,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: con_permasalahan,
                              decoration: const InputDecoration(
                                labelText: 'Permasalahan',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: con_tindakan,
                              decoration: const InputDecoration(
                                labelText: 'Tindakan',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: tgl_pengerjaan,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'Tgl Pengerjaan',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.calendar_today_outlined,
                                  color: APP_COLOR,
                                ),
                              ),
                              onTap: getDateTime_dua,
                            ),
                            SelectFormField(
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              initialValue: 'selesai',
                              items: _items_status,
                              onChanged: (val) {
                                setState(() {
                                  status_pengerjaan = val;
                                });
                              },
                              onSaved: (val) {
                                setState(() {
                                  status_pengerjaan = val;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Status Pengerjaan',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.turned_in_rounded,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: tgl_selesai,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'Tgl Selesai',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.calendar_today_outlined,
                                  color: APP_COLOR,
                                ),
                              ),
                              onTap: getDateTime_tiga,
                            ),
                            TextFormField(
                              controller: con_catatan_petugas,
                              decoration: const InputDecoration(
                                labelText: 'Catatan Petugas',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.note_alt_rounded,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MultiSelectDialogField(
                              items: _items_pelaksanan,
                              title: Row(
                                children: const [
                                  Icon(Icons.group),
                                  Text(' Pelaksana')
                                ],
                              ),
                              selectedColor: APP_COLOR,
                              buttonIcon: const Icon(
                                Icons.group,
                                color: APP_COLOR,
                              ),
                              buttonText: const Text(
                                "Pilih Pelaksana",
                                style: TextStyle(
                                  color: APP_COLOR,
                                  fontSize: 16,
                                ),
                              ),
                              onConfirm: (values) {
                                setState(() {
                                  _selectedpelaksana = values;
                                });
                              },
                              chipDisplay: MultiSelectChipDisplay(
                                onTap: (value) {
                                  setState(() {
                                    _selectedpelaksana.remove(value);
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            showProgress
                                ? const CircularProgressIndicator(
                                    color: APP_COLOR,
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed('/homepage');
                                        },
                                        child: Container(
                                          width: 130,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: APP_COLOR_DANGER,
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (tgl_order.text == '' ||
                                              unit_order == '' ||
                                              unit_tujuan_order == '' ||
                                              barang_order == '' ||
                                              con_detail_barang_order.text ==
                                                  '' ||
                                              con_permasalahan.text == '' ||
                                              con_tindakan.text == '' ||
                                              tgl_pengerjaan.text == '' ||
                                              status_pengerjaan == '' ||
                                              tgl_selesai.text == '' ||
                                              con_catatan_petugas.text == '' ||
                                              _selectedpelaksana.isEmpty) {
                                            Alert(
                                              context: context,
                                              type: AlertType.error,
                                              style: const AlertStyle(
                                                isCloseButton: false,
                                              ),
                                              title: "Oops, Data Kosong",
                                              desc:
                                                  "Lengkapi semua data sebelum menyimpan",
                                              buttons: [
                                                DialogButton(
                                                  color: APP_COLOR,
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                )
                                              ],
                                            ).show();
                                          } else {
                                            setState(() {
                                              showProgress = true;
                                            });
                                            TodoServices()
                                                .AddTodoAct(
                                                    tgl_order.text,
                                                    unit_order,
                                                    unit_tujuan_order,
                                                    barang_order,
                                                    con_detail_barang_order
                                                        .text,
                                                    con_permasalahan.text,
                                                    tgl_pengerjaan.text,
                                                    _selectedpelaksana,
                                                    con_tindakan.text,
                                                    status_pengerjaan,
                                                    tgl_selesai.text,
                                                    con_catatan_petugas.text)
                                                .then((value) {
                                              if (value) {
                                                Alert(
                                                        style: const AlertStyle(
                                                          isCloseButton: false,
                                                        ),
                                                        context: context,
                                                        title: "Info",
                                                        desc:
                                                            "Data Berhasil Disimpan")
                                                    .show();
                                                Navigator.of(context)
                                                    .pushNamed('/homepage');
                                              } else {
                                                setState(() {
                                                  showProgress = false;
                                                });

                                                Alert(
                                                  context: context,
                                                  type: AlertType.error,
                                                  style: const AlertStyle(
                                                    isCloseButton: false,
                                                  ),
                                                  title: "Oops",
                                                  desc: "Data Gagal Disimpan",
                                                  buttons: [
                                                    DialogButton(
                                                      color: APP_COLOR,
                                                      child: const Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ],
                                                ).show();
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 130,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: APP_COLOR,
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Simpan",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
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
