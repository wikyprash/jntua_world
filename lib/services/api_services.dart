import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jntua_world/models/publishedResultsModel.dart';

class ApiServices {
  String apiDomain = 'https://jntua-results-api.herokuapp.com';

  Future<Map<dynamic, dynamic>> getDataFromAPI(String rollno) async {
    String routeName = '/allAttemptedResults';
    String path = '$apiDomain$routeName?rollno=$rollno';
    print('calling api');
    final resp = await http.get(Uri.encodeFull(path));
    if (resp.statusCode == 200) {
      print(resp.statusCode);
      dynamic jd = json.decode(resp.body);
      return jd;
    } else {
      throw Exception('Failed to fetch Results');
    }
  }

  Future<List<PublishedResultsModel>> getPublishedResults() async {
    String routeName = '/publishedResults';
    String path = '$apiDomain$routeName';
    final resp = await http.get(Uri.encodeFull(path));
    if (resp.statusCode == 200) {
      var jsonObject = jsonDecode(resp.body);
      final publishedResultsModel = publishedResultsModelFromJson(JsonEncoder().convert(jsonObject['published_results']));
      return publishedResultsModel;
    } else {
      throw Exception('Failed to fetch Results');
    }
  }
}
