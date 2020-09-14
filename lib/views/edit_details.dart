import 'package:flutter/material.dart';
import 'package:jntua_world/controllers/dark_theme_provider.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/models/user_document_model.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController htncntrlr = TextEditingController();
  User user;
  Future<UserDocumentModel> userDoc;
  CloudFiresotreService cfsi = CloudFiresotreService();

  @override
  void initState() {
    super.initState();
    user = Provider.of<User>(context, listen: false);
    userDoc = cfsi.customUserDocumentObject(user.uid);
  }

  @override
  void dispose() {
    htncntrlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit',
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Hall Ticket Number : "),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: htncntrlr,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        onPressed: () async {
                          print('>updating hall ticket no.');
                          print(htncntrlr.text);
                          await CloudFiresotreService().updateUserResultsData(
                              htncntrlr.text,
                              Provider.of<User>(context, listen: false).uid);
                          Navigator.pop(context);
                          print('updated<');
                        },
                        child: Text(
                          'submit',
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  RaisedButton(
                    child: Text('delete !!!'),
                    onPressed: () =>
                        CloudFiresotreService().deleteUserResult(user.uid),
                  ),
                  SizedBox(height: 50),
                  RaisedButton(
                    child: Text('theme'),
                    onPressed: () {
                      final themeChange = Provider.of<DarkThemeProvider>(
                          context,
                          listen: false);
                      if (themeChange.darkTheme) {
                        setState(() {
                          themeChange.darkTheme = false;
                        });
                      } else {
                        setState(() {
                          themeChange.darkTheme = true;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
