import 'package:jntua_world/screens/displayResults.dart';
import 'package:jntua_world/services/auth_services.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool loading = false;

  @override
  void dispose() {
    myRollNoController.dispose();
    super.dispose();
  }

  final myRollNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('JNTUA world'),
              centerTitle: true,
              elevation: 0,
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.person_outline),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  ),
                ),
              ],
            ),
            endDrawer: Drawer(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Column(
                    children: [
                      RaisedButton(
                        onPressed: () async => await _authService.signOut(),
                        child: Text('LOGOUT'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('HALL TICKET NUMBER : '),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration:
                            InputDecoration(hintText: 'Hall Ticket Number...'),
                        controller: myRollNoController,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DisplayAllResults(
                              rollNo: myRollNoController.text,
                            ),
                          ),
                        );
                      },
                      child: Text('submit'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
