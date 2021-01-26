import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/models/user_document_model.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:provider/provider.dart';

class AllResults extends StatefulWidget {
  @override
  _AllResultsState createState() => _AllResultsState();
}

// with AutomaticKeepAliveClientMixin<Page2>
class _AllResultsState extends State<AllResults>
    {



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('all reults'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'a'),
              Tab(text: 'b'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Text("data"),
            Page2()
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> with AutomaticKeepAliveClientMixin<Page2> {
  Future<UserDocumentModel> userDocumentModel;
  CloudFiresotreService cfssInstance = CloudFiresotreService();

  @override
  void initState() {
    super.initState();
    User user = Provider.of<User>(context, listen: false);
    userDocumentModel = cfssInstance.customUserDocumentObject(user.uid);
  }
    @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<UserDocumentModel>(
      future: userDocumentModel,
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
                                      DataCell(
                                          Text('${item.internals.toString()}')),
                                      DataCell(
                                          Text('${item.externals.toString()}')),
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
    );
  }
}
