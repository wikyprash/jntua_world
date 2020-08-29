import 'package:flutter/material.dart';
import 'package:jntua_world/models/publishedResultsModel.dart';
import 'package:jntua_world/services/api_services.dart';

class PublishedResults extends StatefulWidget {
  @override
  _PublishedResultsState createState() => _PublishedResultsState();
}

class _PublishedResultsState extends State<PublishedResults> {
  Future<List<PublishedResultsModel>> publishedResults;
  ApiServices _apiservices = ApiServices();

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
              print(data);
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (c, i) {
                  return ExpansionTile(
                    title: Text(data[i].title),
                    subtitle: Text(data[i].publishdDate.toString()),
                    trailing: Icon(Icons.arrow_drop_down),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(data[i].url),
                      )
                    ],
                  );
                },
              );
            }
            return Center(child: Text('Loding ..'));
          }),
    );
  }
}
