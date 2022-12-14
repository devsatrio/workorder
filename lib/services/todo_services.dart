import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:workorder/models/all_todo_data.dart';
import 'package:workorder/models/barang_data.dart';
import 'package:workorder/models/dashboard_data.dart';
import 'package:workorder/models/login_data.dart';
import 'package:workorder/models/pelaksanan_data.dart';
import 'package:workorder/models/unit_data.dart';
import 'package:workorder/models/work_order_data.dart';

class DetailPelaksana {
  final String id;
  final String name;

  DetailPelaksana({
    required this.id,
    required this.name,
  });
}

class TodoServices {
  static final String _baseUrl = 'http://192.168.3.4:8000';
  static final String _baseUrlUbuntu = 'http://192.168.227.134:8000';
  static final String _baseUrlLocal = 'http://10.0.2.2:8000';
  static final String _baseUrlServer = 'http://192.168.9.2:8003';
  static final String _finalBaseUrl = _baseUrlServer;

  Future getTodayOrder() async {
    Uri urlApi = Uri.parse(_finalBaseUrl + '/today_order_list');
    try {
      final response = await http.get(urlApi);

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = data_work_order.fromJson(test);
        if (hasil.sts == 'sukses') {
          return hasil;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getDashboard() async {
    DataDashboard datadashboard = new DataDashboard();
    Uri urlApi = Uri.parse(_finalBaseUrl + '/dashboard');
    try {
      final response = await http.get(urlApi);

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = DataDashboard.fromJson(test);
        if (hasil.sts == 'sukses') {
          datadashboard.orderFinishToday = hasil.orderFinishToday;
          datadashboard.orderToday = hasil.orderToday;
          return datadashboard;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getUnit() async {
    List<Map<String, dynamic>> _newitems = [];
    Uri urlApi = Uri.parse(_finalBaseUrl + '/unit');
    try {
      final response = await http.get(urlApi);

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = DataUnit.fromJson(test);
        if (hasil.sts == 'sukses') {
          for (var row in test['data']) {
            _newitems.add(
                {'value': row['id'] + '-' + row['unit'], 'label': row['unit']});
          }
          return _newitems;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getWorkList() async {
    List<Map<String, dynamic>> _newitems = [];
    Uri urlApi = Uri.parse(_finalBaseUrl + '/work_list');
    try {
      final response = await http.get(urlApi);

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = DataBarang.fromJson(test);
        if (hasil.sts == 'sukses') {
          for (var row in test['data']) {
            _newitems
                .add({'value': row['jenis_work'], 'label': row['jenis_work']});
          }
          return _newitems;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getPelaksana() async {
    List<DetailPelaksana> _items_pelaksana = [];
    List<MultiSelectItem<Object?>> final_items_pelaksanan = [];

    Uri urlApi = Uri.parse(_finalBaseUrl + '/work_pelaksana');
    try {
      final response = await http.get(urlApi);
      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = DataPelaksanan.fromJson(test);
        if (hasil.sts == 'sukses') {
          for (var row in test['data']) {
            _items_pelaksana
                .add(DetailPelaksana(id: row['pelaksana'], name: row['pelaksana']));
          }
          final_items_pelaksanan = _items_pelaksana
              .map((pelaksana) =>
                  MultiSelectItem<DetailPelaksana>(pelaksana, pelaksana.name))
              .toList();
          return final_items_pelaksanan;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future AddTodoAct(
      String tgl_order,
      String? id_unit,
      String? tujuan,
      String? nama_barang,
      String detail_barang,
      String permasalahan,
      String tgl_execute,
      List<Object?> pelaksana,
      String tindakan,
      String? hasil,
      String tgl_finish,
      String catatan_petugas) async {
    Uri urlApi = Uri.parse(_finalBaseUrl + '/work_order');
    String final_pelaksana = '';
    var map1 =Map.fromIterable(pelaksana, key: (e) => e.id, value: (e) => e.name);
    map1.forEach((key, value) {
      final_pelaksana = final_pelaksana + ',' + value.toString();
    });
    try {
      final response = await http.post(urlApi,
          body: ({
            "tgl_order": tgl_order,
            "id_unit": id_unit,
            "tujuan": tujuan,
            "nama_barang": nama_barang,
            "detail_barang": detail_barang,
            "permasalahan": permasalahan,
            "tgl_execute": tgl_execute,
            "pelaksana": final_pelaksana,
            "tindakan": tindakan,
            "hasil": hasil,
            "tgl_finish": tgl_finish,
            "catatan_petugas": catatan_petugas,
          }));
      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = logindata.fromJson(test);
        if (hasil.sts == 'sukses') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future Editdata(
      String kode_wo,
      String tgl_order,
      String? id_unit,
      String? tujuan,
      String? nama_barang,
      String detail_barang,
      String permasalahan,
      String tgl_execute,
      List<Object?> pelaksana,
      String tindakan,
      String? hasil,
      String tgl_finish,
      String catatan_petugas) async{
    Uri urlApi = Uri.parse(_finalBaseUrl + '/work_order/update');
    String final_pelaksana = '';
    var map1 =Map.fromIterable(pelaksana, key: (e) => e.id, value: (e) => e.name);
    map1.forEach((key, value) {
      final_pelaksana = final_pelaksana + ',' + value.toString();
    });
    try {
      final response = await http.post(urlApi,
          body: ({
            "kode_wo":kode_wo,
            "tgl_order": tgl_order,
            "id_unit": id_unit,
            "tujuan": tujuan,
            "nama_barang": nama_barang,
            "detail_barang": detail_barang,
            "permasalahan": permasalahan,
            "tgl_execute": tgl_execute,
            "pelaksana": final_pelaksana,
            "tindakan": tindakan,
            "hasil": hasil,
            "tgl_finish": tgl_finish,
            "catatan_petugas": catatan_petugas,
          }));
      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = logindata.fromJson(test);
        if (hasil.sts == 'sukses') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future DeleteTodoAct(String idwo) async {
    Uri urlApi = Uri.parse(_finalBaseUrl + '/work_order/delete');
    try {
      final response = await http.post(urlApi,
          body: ({
            "idwo": idwo,
          }));
      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = logindata.fromJson(test);
        if (hasil.sts == 'sukses') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future getAllDataOrder(page_number, String cari_val) async{

    Uri urlApi = Uri.parse(_finalBaseUrl + '/work_order/all_order?cari='+cari_val+'&page='+page_number.toString());
    try {
      final response = await http.get(urlApi);

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = AllTodoData.fromJson(test);
        return hasil;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
