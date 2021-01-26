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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Published Results'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'your\'s'),
              Tab(text: 'ALL'),
            ],
          ),
        ),
        body: TabBarView(
          children: [PRTab1(), PRTab2()],
        ),
      ),
    );
  }
}

class PRTab1 extends StatefulWidget {
  @override
  _PRTab1State createState() => _PRTab1State();
}

class _PRTab1State extends State<PRTab1>
    with AutomaticKeepAliveClientMixin<PRTab1> {
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
    super.build(context);
    return Container(
      child: FutureBuilder<List<PublishedResultsModel>>(
        future: publishedResults,
        builder: (c, s) {
          if (s.hasData) {
            var data = s.data
                .where((element) =>
                    element.title.toLowerCase().contains('b.tech') &&
                    element.title.toLowerCase().contains('r15'))
                .toList();
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
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class PRTab2 extends StatefulWidget {
  @override
  _PRTab2State createState() => _PRTab2State();
}

class _PRTab2State extends State<PRTab2>
    with AutomaticKeepAliveClientMixin<PRTab2> {
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
    super.build(context);
    return Container(
        child: FutureBuilder<List<PublishedResultsModel>>(
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
                  subtitle: Text(
                      convertDateTimeDisplay(data[i].publishdDate.toString())),
                  trailing: Icon(Icons.launch),
                ),
              );
            },
          );
        }
        return Center(child: Text('Loding ..'));
      },
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
