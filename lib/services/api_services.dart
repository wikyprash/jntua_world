import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  String apiDomain = 'https://jntua-results-api.herokuapp.com';
  String routeName = '/allattemptedresultsdata';

  Future<Map<dynamic, dynamic>> getDataFromAPI(String rollno) async {
    String path = '$apiDomain$routeName?rollno=163g1a0505';
    final resp = await http.get(Uri.encodeFull(path));
    if (resp.statusCode == 200) {
      print(resp.statusCode);
      dynamic jd = json.decode(resp.body);
      return jd;
    } else {
      throw Exception('Failed to fetch Results');
    }
  }
}
