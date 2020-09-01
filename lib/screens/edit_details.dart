import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/models/userDocumentModel.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController htncntrlr =  TextEditingController();
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
          backgroundColor: Colors.white,
          title: Text(
            'Edit',
            style: TextStyle(color: Colors.black45),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            color: Colors.black54,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
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
                            color: Colors.black45,
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
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.black,
                        onPressed: () async {
                          print('>updating hall ticket no.');
                          print(htncntrlr.text);
                          await CloudFiresotreService().updateUserResultsData(
                              htncntrlr.text, Provider.of<User>(context, listen: false).uid);
                          Navigator.pop(context);
                          print('updated<');
                        },
                        child: Text(
                          'submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  RaisedButton(onPressed: () => CloudFiresotreService().deleteUserResult(user.uid))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
