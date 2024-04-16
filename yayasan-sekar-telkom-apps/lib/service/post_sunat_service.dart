import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/sunat_model.dart';
import '../url.dart';

class SunatService {
  Future<bool> postSunatData(SunatModel sunat) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Retrieve token from FlutterSecureStorage
    String? token = await FlutterSecureStorage().read(key: 'token');

    if (token != null) {
      headers['Authorization-1'] = 'Bearer $token';
    } else {
      print('Token not available. User is not logged in.');
      return false;
    }

    try {
      var response = await http.post(
        Uri.parse("${Url().val}sunat"),
        headers: headers,
        body: jsonEncode(sunat.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to post sunat data. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error posting sunat data: $error');
      return false;
    }
  }
}
