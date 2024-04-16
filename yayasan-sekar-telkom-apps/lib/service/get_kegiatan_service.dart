import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yayasan_sekar_telkom_apps/model/kegiatan_model.dart';
import '../url.dart';

class KegiatanService {
  Future<List<KegiatanModel>> fetchKegiatanData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var result =
          await http.get(Uri.parse("${Url().val}kegiatan"), headers: headers);

      if (result.statusCode == 200) {
        List<dynamic> dat = json.decode(result.body)['data'] ?? [];
        List<KegiatanModel> kegiatanModel =
            dat.map((data) => KegiatanModel.fromJson(data)).toList();
        return kegiatanModel;
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
