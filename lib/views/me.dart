import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/models/user_document_model.dart';
import 'package:jntua_world/views/edit_page.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:jntua_world/views/settings.dart';
import 'package:jntua_world/zres/widgets/custommRRB.dart';
import 'package:provider/provider.dart';

class Me extends StatefulWidget {
  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  Future<UserDocumentModel> userDocumentModel;
  CloudFiresotreService cfsi = CloudFiresotreService();
  var hallTkNo;
  User user;
  @override
  void initState() {
    super.initState();
    user = Provider.of<User>(context, listen: false);
    userDocumentModel = cfsi.customUserDocumentObject(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ME'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(user.photoUrl)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection("users")
                    .document(user.uid)
                    .snapshots(),
                builder: (c, s) {
                  if (s.hasData) {
                    var data = s.data;
                    if (data['results'] != null) {
                      var stdName = data['results']['Student name'];
                      hallTkNo = data['results']['Hall Ticket No'];
                      var course = data['results']['course'];
                      var reg = data['results']['regulation'];
                      return data['results'] != null
                          ? Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    // padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Text('name'),
                                        Text(stdName),
                                        // Text('Hall tickent no :'),
                                        Text('$hallTkNo'),
                                        // Text('course : '),
                                        Text('$course'),
                                        // Text('reg : '),
                                        Text('$reg'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  CustomRRB(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Edit(htkno: hallTkNo)));
                                      },
                                      txt: 'Edit')
                                ],
                              ),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  RaisedButton(
                                    child: Text('enter details'),
                                    onPressed: () {
                                      print(reg);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Edit()));
                                    },
                                  )
                                ],
                              ),
                            );
                    }
                  } else if (s.hasError) {
                    print('error');
                  }
                  return Center(
                      child: Container(
                    child: Column(
                      children: [
                        RaisedButton(
                          child: Text('enter details'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Edit()));
                          },
                        )
                      ],
                    ),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
