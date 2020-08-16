import 'package:flutter/material.dart';
import 'package:jntua_world/models/results.dart';
import 'package:jntua_world/services/api_services.dart';

class DisplayAllResults extends StatefulWidget {
  final rollNo;

  const DisplayAllResults({Key key, this.rollNo}) : super(key: key);

  @override
  _DisplayAllResultsState createState() => _DisplayAllResultsState();
}

class _DisplayAllResultsState extends State<DisplayAllResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<Results>(
          future: getDataFromAPI(widget.rollNo),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    ListTile(
                      title: Text('${snapshot.data.studentName}'),
                    ),
                    ListTile(
                      title: Text('${snapshot.data.hallTicketNo}'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(snapshot
                                    .data.results[index]['title']
                                    .toString()),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columnSpacing: 10,
                                  columns: [
                                    DataColumn(
                                        label: Text('Subject Code')),
                                    DataColumn(
                                        label: Text('Subject Name')),
                                    DataColumn(label: Text('Internals')),
                                    DataColumn(label: Text('Externals')),
                                    DataColumn(
                                        label: Text('Total Marks')),
                                    DataColumn(
                                        label: Text('Result Status')),
                                    DataColumn(label: Text('Credits')),
                                    DataColumn(label: Text('Grades')),
                                  ],
                                  rows: [
                                    for (var item in snapshot
                                        .data.results[index]['data'])
                                      DataRow(
                                        cells: [
                                          DataCell(Text(
                                              '${item['Subject Code'].toString()}')),
                                          DataCell(Text(
                                              '${item['Subject Name'].toString()}')),
                                          DataCell(Text(
                                              '${item['Internals'].toString()}')),
                                          DataCell(Text(
                                              '${item['Externals'].toString()}')),
                                          DataCell(Text(
                                              '${item['Total Marks'].toString()}')),
                                          DataCell(Text(
                                              '${item['Result Status'].toString()}')),
                                          DataCell(Text(
                                              '${item['Credits'].toString()}')),
                                          DataCell(Text(
                                              '${item['Grades'].toString()}')),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
