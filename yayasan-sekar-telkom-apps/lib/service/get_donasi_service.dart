import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yayasan_sekar_telkom_apps/model/donasi_model.dart';
import '../url.dart';

class ProgramDonasiService {
  Future<List<ProgramDonasiModel>> fetchDonasiData() async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      var result = await http.get(Uri.parse("${Url().val}programDonasi"),
          headers: headers);

      if (result.statusCode == 200) {
        List<dynamic> dat = json.decode(result.body)['data'] ?? [];
        List<ProgramDonasiModel> programDonasiModel =
            dat.map((data) => ProgramDonasiModel.fromJson(data)).toList();
        return programDonasiModel;
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
