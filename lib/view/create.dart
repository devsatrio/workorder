import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:workorder/constants/appcolors.dart';
import 'package:workorder/services/todo_services.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late Future dataUnit;
  late Future dataBarang;
  List<Map<String, dynamic>> _items = [];
  List<Map<String, dynamic>> _items_barang = [];
  final List<Map<String, dynamic>> _items_status = [
    {'value': 'selesai', 'label': 'Selesai'},
    {'value': 'belum', 'label': 'Belum'},
    {'value': 'proses', 'label': 'Proses'},
    {'value': 'pending', 'label': 'Pending'},
  ];

  TextEditingController tgl_order = TextEditingController();
  TextEditingController tgl_pengerjaan = TextEditingController();
  TextEditingController tgl_selesai = TextEditingController();

  Future getDateTime() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    }

    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
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
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    }

    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
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
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    }

    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
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
                  SizedBox(height: 55.0),
                  Container(
                    alignment: Alignment.topRight,
                    child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text('Make new to do data')),
                  ),
                  SizedBox(height: 5.0),
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
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
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
                                  Icons.perm_identity,
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
                              onChanged: (val) => print(val),
                              onSaved: (val) => print(val),
                              decoration: const InputDecoration(
                                labelText: 'Unit',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            SelectFormField(
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              initialValue: 'UNI.0092',
                              items: _items,
                              onChanged: (val) => print(val),
                              onSaved: (val) => print(val),
                              decoration: const InputDecoration(
                                labelText: 'Unit Tujuan',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            SelectFormField(
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              initialValue: '',
                              items: _items_barang,
                              onChanged: (val) => print(val),
                              onSaved: (val) => print(val),
                              decoration: const InputDecoration(
                                labelText: 'Barang',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Detail Barang',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Permasalahan',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
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
                                  Icons.perm_identity,
                                  color: APP_COLOR,
                                ),
                              ),
                              onTap: getDateTime_dua,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Pelaksana',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            SelectFormField(
                              type: SelectFormFieldType
                                  .dropdown, // or can be dialog
                              initialValue: 'selesai',
                              items: _items_status,
                              onChanged: (val) => print(val),
                              onSaved: (val) => print(val),
                              decoration: const InputDecoration(
                                labelText: 'Status Pengerjaan',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
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
                                  Icons.perm_identity,
                                  color: APP_COLOR,
                                ),
                              ),
                              onTap: getDateTime_tiga,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Catatan Petugas',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: APP_COLOR),
                                ),
                                prefixIcon: Icon(
                                  Icons.perm_identity,
                                  color: APP_COLOR,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: APP_COLOR,
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
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
