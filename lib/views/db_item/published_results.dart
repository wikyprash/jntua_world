import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jntua_world/models/published_results_model.dart';
import 'package:jntua_world/services/api_services.dart';
import 'package:url_launcher/url_launcher.dart';

class PublishedResults extends StatefulWidget {
  @override
  _PublishedResultsState createState() => _PublishedResultsState();
}

class _PublishedResultsState extends State<PublishedResults> {
  Future<List<PublishedResultsModel>> publishedResults;
  ApiServices _apiservices = ApiServices();

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  @override
  void initState() {
    super.initState();
    publishedResults = _apiservices.getPublishedResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Published Results'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PublishedResultsModel>>(
          future: publishedResults,
          builder: (c, s) {
            if (s.hasData) {
              var data = s.data;
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(height: 5),
                itemCount: data.length,
                itemBuilder: (c, i) {
                  return InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () async {
                      try {
                        var url = data[i].url;
                        launch(url);
                      } catch (e) {
                        print('error');
                      }
                    },
                    child: ListTile(
                      title: Text(data[i].title),
                      subtitle: Text(convertDateTimeDisplay(
                          data[i].publishdDate.toString())),
                      trailing: Icon(Icons.launch),
                    ),
                  );
                },
              );
            }
            return Center(child: Text('Loding ..'));
          }),
    );
  }
}
