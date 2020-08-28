import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:provider/provider.dart';

class Me extends StatelessWidget {
  const Me({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(Provider.of<User>(context).name);
  }
}