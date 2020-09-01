import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/models/userDocumentModel.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:provider/provider.dart';

class AllResults extends StatefulWidget {
  @override
  _AllResultsState createState() => _AllResultsState();
}

class _AllResultsState extends State<AllResults> {
  CloudFiresotreService cfssInstance = CloudFiresotreService();

  Future<UserDocumentModel> res;

  @override
  void initState() {
    super.initState();
    User user = Provider.of<User>(context, listen: false);
    res = cfssInstance.customUserDocumentObject(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Results'),
      ),
      body: FutureBuilder<UserDocumentModel>(
        future: res,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ResultsData> data = snapshot.data.results.resultsData;
            return SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(data[index].title.toString()),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: DataTable(
                                columnSpacing: 05,
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
                                  for (var item in data[index].data)
                                    DataRow(
                                      cells: [
                                        DataCell(Text(
                                            '${item.subjectCode.toString()}')),
                                        DataCell(Text(
                                            '${item.subjectName.toString()}')),
                                        DataCell(Text(
                                            '${item.internals.toString()}')),
                                        DataCell(Text(
                                            '${item.externals.toString()}')),
                                        DataCell(Text(
                                            '${item.totalMarks.toString()}')),
                                        DataCell(Text(
                                            '${item.resultStatus.toString()}')),
                                        DataCell(
                                            Text('${item.credits.toString()}')),
                                        DataCell(
                                            Text('${item.grades.toString()}')),
                                      ],
                                    ),
                                ],
                              ),
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
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
