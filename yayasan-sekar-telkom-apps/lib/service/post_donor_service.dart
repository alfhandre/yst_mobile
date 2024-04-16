import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/donor_model.dart';
import '../url.dart';

class DonorService {
  Future<bool> postDonorData(DonorModel donor) async {
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
        Uri.parse("${Url().val}relawan/programDonor"),
        headers: headers,
        body: jsonEncode(donor.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to post donor data. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return false;
      }
    } catch (error) {
      print('Error posting donor data: $error');
      return false;
    }
  }
}
