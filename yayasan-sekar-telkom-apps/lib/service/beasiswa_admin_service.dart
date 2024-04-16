import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yayasan_sekar_telkom_apps/model/beasiswa_admin_model.dart';
import '../url.dart';

class BeasiswaAdminService {
  String? token;

  _getToken() async {
    token = await const FlutterSecureStorage().read(key: "token");
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization-1': 'Bearer $token',
      };

  Future<List<BeasiswaAdminModel>> getBeasiswaAdmin() async {
    await _getToken();
    final res = await http.get(
      Uri.parse("${Url().val}beasiswa"),
      headers: _setHeaders(),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final convertDataToJson = jsonDecode(res.body);
      List list = convertDataToJson['data'];
      return list.map((data) => BeasiswaAdminModel.fromJson(data)).toList();
    } else {
      throw "Failed to load beasiswa list";
    }
  }

  // Future<bool> createBeasiswaAdmin(Map beasiswa) async {
  //   await _getToken();
  //   final res = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: _setHeaders(),
  //     body: jsonEncode(beasiswa), // Convert to JSON
  //   );
  //   if (res.statusCode == 200 || res.statusCode == 201) {
  //     // return BeasiswaAdminModel.fromJson(convertDataToJson['data']);
  //     return true;
  //   }
  //   return false;
  // }

  // Future<void> updateBeasiswaAdmin(BeasiswaAdminModel beasiswa) async {
  //   await _getToken();
  //   final res = await http.patch(
  //     Uri.parse('$apiUrl/${beasiswa.idBeasiswa}'),
  //     headers: _setHeaders(),
  //     body: jsonEncode(beasiswa.toJson()), // Convert to JSON
  //   );
  //   if (res.statusCode != 200) {
  //     throw Exception("Failed to update beasiswa");
  //   }
  // }

  // Future<void> deleteBeasiswaAdmin(
  //     int idBeasiswa, BeasiswaAdminModel beasiswa) async {
  //   await _getToken();
  //   final res = await http.delete(
  //     Uri.parse('$apiUrl/$idBeasiswa'),
  //     headers: _setHeaders(),
  //   );
  //   if (res.statusCode != 204) {
  //     throw Exception("Failed to delete beasiswa");
  //   }
  // }
}
