import 'package:flutter/material.dart';
import 'package:jntua_world/models/results.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';

class DisplayAllResults extends StatefulWidget {
  @override
  _DisplayAllResultsState createState() => _DisplayAllResultsState();
}

class _DisplayAllResultsState extends State<DisplayAllResults> {
  CloudFiresotreService cfssInstance = CloudFiresotreService();

  Future<Results> res;

  @override
  void initState() {
    super.initState();
    res = cfssInstance.getDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Results'),
      ),
      body: FutureBuilder<Results>(
        future: res,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.resultsData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(snapshot
                                .data.resultsData[index]['title']
                                .toString()),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 10,
                              columns: [
                                DataColumn(label: Text('Subject Code')),
                                DataColumn(label: Text('Subject Name')),
                                DataColumn(label: Text('Internals')),
                                DataColumn(label: Text('Externals')),
                                DataColumn(label: Text('Total Marks')),
                                DataColumn(label: Text('Result Status')),
                                DataColumn(label: Text('Credits')),
                                DataColumn(label: Text('Grades')),
                              ],
                              rows: [
                                for (var item
                                    in snapshot.data.resultsData[index]['data'])
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
                                      DataCell(
                                          Text('${item['Grades'].toString()}')),
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
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
