import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yayasan_sekar_telkom_apps/url.dart';

class RegisterService {
  headers() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
  Future<bool> register(Map data) async {
    String jsonData = jsonEncode(data);
    String apiURL = "${Url().val}register";
    final res =
        await http.post(Uri.parse(apiURL), body: jsonData, headers: headers());
    if (res.statusCode == 200) {
      final convertDataToJson = json.decode(res.body);
      return true;
    }
    return false;
  }
}
