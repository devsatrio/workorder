import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workorder/models/login_data.dart';

class LoginServices {
  static final String _baseUrl = 'http://192.168.3.51:8000';

  Future loginAct(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    Uri urlApi = Uri.parse(_baseUrl + '/login');
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
          print(prefs.getString('username'));
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
