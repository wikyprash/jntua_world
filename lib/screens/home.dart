import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/screens/dashboard.dart';
import 'package:jntua_world/screens/me.dart';
import 'package:flutter/material.dart';
import 'package:jntua_world/screens/settings.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Me(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
                  context, MaterialPageRoute(builder: (context) => Settings()));
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
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('me'),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
      // Center(
      //   child: RaisedButton(
      //     onPressed: () async {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => DisplayAllResults(),
      //         ),
      //       );
      //     },
      //     child: Text('show all results'),
      //   ),
      // ),
    );
  }
}
