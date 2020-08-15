import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('HOME'),
              centerTitle: true,
              elevation: 0,
            ),
            body: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(Provider.of<User>(context).photoUrl),
                      radius: 70,
                    ),
                    SizedBox(height: 80),
                    Text(Provider.of<User>(context).name),
                    SizedBox(height: 10),
                    Text(Provider.of<User>(context).email),
                    SizedBox(height: 50),
                    RaisedButton(
                      onPressed: () async {
                         _authService.signOut();
                        setState(() => loading = true);
                        print('signed out');
                      },
                      child: Text('SIGN OUT'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
