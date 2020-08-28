import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jntua_world/models/user.dart';
import 'package:jntua_world/screens/displayAllResults.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CloudFiresotreService cfsi = CloudFiresotreService();
    User user = Provider.of<User>(context);
    return Container(
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
                            builder: (context) => DisplayAllResults()));
                  } else {
                    final snackBar =
                        SnackBar(content: Text('results not available'));
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.blue[300],
                  child: Center(child: Text('all resutls')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  cfsi.deleteUserResult(user.uid);
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.blue[300],
                  child: Center(child: Text('delete resutls')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () async {
                  cfsi.updateUserResultsData('163g1a0505', user.uid);
                },
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.blue[300],
                  child: Center(child: Text('update resutls')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
