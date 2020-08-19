import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/screens/displayResults.dart';
import 'package:jntua_world/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void dispose() {
    myRollNoController.dispose();
    super.dispose();
  }

  final myRollNoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JNTUA world'),
        centerTitle: true,
        elevation: 0,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(Provider.of<User>(context).photoUrl),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayAllResults(),
              ),
            );
          },
          child: Text('show all results'),
        ),
      ),
    );
  }
}
