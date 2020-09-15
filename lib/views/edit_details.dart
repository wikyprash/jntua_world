import 'package:flutter/material.dart';
import 'package:jntua_world/controllers/dark_theme_provider.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/models/user_document_model.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:jntua_world/zres/colors.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  User user;
  Future<UserDocumentModel> userDoc;
  CloudFiresotreService cfsi = CloudFiresotreService();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> courses = ["B.Tech"];
  List<String> regulations = ["R15"];

  TextEditingController htncntrlr = TextEditingController();
  String courseSelected = "B.Tech";
  String regulationSelected = "R15";
  // String courseSelected;
  // String regulationSelected;

  void _doSomething() async {
    FocusScope.of(context).unfocus();
    print(htncntrlr.text);
    print(courseSelected);
    print(regulationSelected);
    try {
      if (_formKey.currentState.validate()) {
        print('>updating hall ticket no.');
        await CloudFiresotreService().updateUserResultsData(
            uid: Provider.of<User>(context, listen: false).uid,
            rollno: htncntrlr.text,
            course: courseSelected,
            regulation: regulationSelected);
        Navigator.pop(context);
        print('updated<');
      } else {
        print('invalid details');

        // final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
        // // Find the Scaffold in the widget tree and use it to show a SnackBar.
        // Scaffold.of(context).showSnackBar(snackBar);

        _btnController.reset();
      }
    } catch (e) {}
  }

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
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Hall Ticket Number : "),
                        HallTicketField(htncntrlr: htncntrlr),
                        Row(
                          children: [
                            SizedBox(width: 50),
                            DropdownButton<String>(
                              hint: Text('Course'),
                              items: courses.map((String item) {
                                return new DropdownMenuItem<String>(
                                  value: item,
                                  child: new Text(item),
                                );
                              }).toList(),
                              onChanged: (String selectedItem) {
                                setState(() {
                                  this.courseSelected = selectedItem;
                                });
                              },
                              value: courseSelected,
                            ),
                            SizedBox(width: 50),
                            DropdownButton<String>(
                              hint: Text('Regulation'),
                              items: regulations.map((String item) {
                                return new DropdownMenuItem<String>(
                                  value: item,
                                  child: new Text(item),
                                );
                              }).toList(),
                              onChanged: (String selectedItem) {
                                setState(() {
                                  this.regulationSelected = selectedItem;
                                });
                              },
                              value: regulationSelected,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  RoundedLoadingButton(
                    child: Text(
                      'SUBMIT',
                    ),
                    controller: _btnController,
                    color: m01,
                    onPressed: _doSomething,
                  ),
                  SizedBox(height: 50),
                  RaisedButton(
                    child: Text('delete !!!'),
                    onPressed: () =>
                        CloudFiresotreService().deleteUserResult(user.uid),
                  ),
                  SizedBox(height: 10),
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

class HallTicketField extends StatelessWidget {
  const HallTicketField({
    Key key,
    @required this.htncntrlr,
  }) : super(key: key);

  final TextEditingController htncntrlr;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 15),
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          validator: (String value) {
            if (value.length != 10) {
              return 'invalid ht no.';
            }
            return null;
          },
          autofocus: true,
          controller: htncntrlr,
          decoration: InputDecoration(
            hintText: 'enter hall ticke number',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
