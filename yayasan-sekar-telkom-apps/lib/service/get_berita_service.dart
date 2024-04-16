import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/berita_model.dart';
import '../url.dart';

class BeritaService {
  Future<List<BeritaModel>> fetchBeritaData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var result =
          await http.get(Uri.parse("${Url().val}berita"), headers: headers);

      if (result.statusCode == 200) {
        List<dynamic> dat = json.decode(result.body)['data'] ?? [];
        List<BeritaModel> beritaModel =
            dat.map((data) => BeritaModel.fromJson(data)).toList();
        return beritaModel;
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
