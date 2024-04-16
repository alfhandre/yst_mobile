import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yayasan_sekar_telkom_apps/model/relawan_model.dart';
import '../url.dart';

class ProgramRelawanService {
  Future<List<ProgramRelawanModel>> fetchRelawanData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var result = await http.get(Uri.parse("${Url().val}programRelawan"),
          headers: headers);

      if (result.statusCode == 200) {
        List<dynamic> dat = json.decode(result.body)['data'] ?? [];
        List<ProgramRelawanModel> programRelawanModel =
            dat.map((data) => ProgramRelawanModel.fromJson(data)).toList();
        return programRelawanModel;
      } else {
        print('Failed to load data. Status Code: ${result.statusCode}');
        return [];
      }
    } catch (error) {
      print('Error fetching data: $error');
      return [];
    }
  }
}
