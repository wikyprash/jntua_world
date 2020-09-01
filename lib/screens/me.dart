import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/models/userDocumentModel.dart';
import 'package:jntua_world/screens/edit_details.dart';
import 'package:jntua_world/services/auth_services.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:provider/provider.dart';

class Me extends StatefulWidget {
  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  Future<UserDocumentModel> userDocumentModel;
  CloudFiresotreService cfsi = CloudFiresotreService();

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          color: Colors.black54,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            color: Colors.black54,
            icon: Icon(Icons.call_end),
            onPressed: () {
              AuthService().signOut();
              Navigator.pop(context);
            },
          ),
          IconButton(
            color: Colors.black54,
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Edit()));
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
                    print(data['userAccountDetails']);
                    return data['results'] != null
                        ? Container(
                            child: Column(
                              children: [
                                Text(data['results']['Student name']),
                                Text(data['results']['Hall Ticket No']),
                              ],
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                RaisedButton(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [Text('htn'), Icon(Icons.edit)],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Edit()));
                                  },
                                )
                              ],
                            ),
                          );
                  } else if (s.hasError) {
                    print('error');
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
