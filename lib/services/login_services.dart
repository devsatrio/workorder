import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workorder/models/login_data.dart';

class LoginServices {
  static final String _baseUrl = 'http://192.168.3.4:8000';
  static final String _baseUrlUbuntu = 'http://192.168.227.134:8000';
  static final String _baseUrlLocal = 'http://10.0.2.2:8000';
  static final String _baseUrlServer = 'http://192.168.9.2:8003';
  static final String _finalBaseUrl = _baseUrlServer;

  Future loginAct(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    Uri urlApi = Uri.parse(_finalBaseUrl + '/login');
    try {
      final response = await http.post(urlApi,
          body: ({
            "username": username,
            "password": password,
          }));

      if (response.statusCode == 200) {
        var test = jsonDecode(response.body);
        var hasil = logindata.fromJson(test);
        if (hasil.sts == 'sukses') {
          String? res_username = hasil.data![0].user;
          String? res_unit = hasil.data![0].user;
          await prefs.setBool('login', true);
          await prefs.setString('username', res_username!);
          await prefs.setString('unit', res_unit!);
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
}
