import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../url.dart';

class LoginService {
  int? status, statusCode;
  String? message, levelUser;

  LoginService({required this.message, this.levelUser});

  factory LoginService.fromJson(Map<String, dynamic> attendanceObject) {
    return LoginService(
      message: attendanceObject['message'],
      levelUser: attendanceObject['level_user'] ?? 'null',
    );
  }

  static Future<LoginService> toJson(
    String email,
    String password,
  ) async {
    String apiURL = "${Url().val}login";
    var response = await http.post(
      Uri.parse(apiURL),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    var jsonObject = jsonDecode(response.body);
    var dataStatus = json.decode(response.body);
    print(dataStatus);

    if (response.statusCode == 200) {
      const FlutterSecureStorage().write(
        key: "token",
        value: dataStatus['token'],
      );
      const FlutterSecureStorage().write(
        key: "level_user",
        value: dataStatus['level_user'],
      );
      const FlutterSecureStorage().write(
        key: "name",
        value: dataStatus['name'],
      );
      const FlutterSecureStorage().write(key: 'email', value: email);
    }
    print(FlutterSecureStorage().read(key: 'level_user'));

    // print('Login : ' + jsonObject.toString());
    var data = (jsonObject as Map<String, dynamic>);
    return LoginService.fromJson(data);
  }
}
