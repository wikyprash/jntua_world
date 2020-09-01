import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/screens/all_results.dart';
import 'package:jntua_world/screens/publishedResults.dart';
import 'package:jntua_world/screens/me.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CloudFiresotreService cfsi = CloudFiresotreService();
    User user = Provider.of<User>(context);
    return Container(
      child: Column(
        children: [
          // user card
          ProfileCard(),
          SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          DocumentSnapshot doc =
                              await cfsi.getDoc(user.uid).get();
                          if (doc.data['results'] != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllResults()));
                          } else {
                            final snackBar = SnackBar(
                                content: Text('results not available'));
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.blue[300],
                          child: Center(child: Text('All Resutls')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PublishedResults()));
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          color: Colors.blue[300],
                          child: Center(child: Text('Published Results')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return InkWell(
      onTap: () {
        print('object');
        Navigator.push(context, MaterialPageRoute(builder: (context) => Me()));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(user.photoUrl),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(user.name), Text(user.email)],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
