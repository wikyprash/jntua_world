import 'package:jntua_world/services/auth_services.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final AuthService _authService = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('login/signup'),
                  RaisedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          loading = true;
                        });
                        var r = await _authService.signInWithGoogle();
                        print('<<<<<<< $r >>>>>>>');
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: Text('sign in with google'),
                  )
                ],
              ),
            ),
          );
  }
}
