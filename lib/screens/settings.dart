import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/models/userDocument.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  CloudFiresotreService cfsi = CloudFiresotreService();

  Future<UserDocumentModel> rez;
  TextEditingController htcntrlr = TextEditingController();
  bool loading;
  
  @override
  void initState() {
    super.initState();
    User user = Provider.of<User>(context, listen: false);
    rez = cfsi.customUserDocumentObject(user.uid);
  }

  @override
  void dispose() {
    htcntrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(user.photoUrl)),
              ),
            ),
            FutureBuilder<UserDocumentModel>(
              future: rez,
              builder: (c, s) {
                if (s.hasData) {
                  UserDocumentModel data = s.data;
                  return data.results != null
                      ? Container(
                          child: Column(
                            children: [
                              Text(data.results.studentName),
                              Text(data.results.hallTicketNo),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(controller: htcntrlr),
                              ),
                              RaisedButton(
                                child: Text("submit hall ticket number"),
                                onPressed: () {
                                  cfsi.updateUserResultsData(
                                      htcntrlr.text, user.uid);
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
            )
          ],
        ),
      ),
    );
  }
}
