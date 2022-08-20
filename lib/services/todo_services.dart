import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:workorder/models/barang_data.dart';
import 'package:workorder/models/pelaksanan_data.dart';
import 'package:workorder/models/unit_data.dart';

class TodoServices {
  static final String _baseUrl = 'http://192.168.3.51:8000';
  static final String _baseUrlUbuntu = 'http://192.168.211.134:8000';

  Future getUnit() async {
    List<Map<String, dynamic>> _newitems=[];
    Uri urlApi = Uri.parse(_baseUrlUbuntu + '/unit');
    try {
      final response = await http.get(urlApi);

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = DataUnit.fromJson(test);
        if (hasil.sts == 'sukses') {
          for (var row in test['data']) {
            _newitems.add({'value': row['id'], 'label': row['unit']});
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

  Future getWorkList() async{
    List<Map<String, dynamic>> _newitems=[];
    Uri urlApi = Uri.parse(_baseUrlUbuntu + '/work_list');
    try {
      final response = await http.get(urlApi);

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = DataBarang.fromJson(test);
        if (hasil.sts == 'sukses') {
          for (var row in test['data']) {
            _newitems.add({'value': row['idwl'], 'label': row['jenis_work']});
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

  Future getPelaksana() async{
    List<Map<String, dynamic>> _newitems=[];
    Uri urlApi = Uri.parse(_baseUrlUbuntu + '/work_pelaksana');
    try {
      final response = await http.get(urlApi);

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = DataPelaksanan.fromJson(test);
        if (hasil.sts == 'sukses') {
          for (var row in test['data']) {
            _newitems.add({'value': row['id'], 'label': row['pelaksana']});
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
}
