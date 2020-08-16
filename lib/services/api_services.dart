import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jntua_world/models/results.dart';

Future<Results> getDataFromAPI(rollno) async {
  print('fetching...');
  String url = 'https://jntua-world-api.herokuapp.com/$rollno';
  final resp = await http.get(Uri.encodeFull(url));
  if (resp.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(resp.statusCode);
    dynamic jd = json.decode(resp.body);
    print(jd['user']['Student name']);
    return Results.fromJson(jd);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
