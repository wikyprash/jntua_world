import 'package:flutter/material.dart';
import 'package:jntua_world/models/results.dart';
import 'package:jntua_world/res/widgets/custommRRB.dart';
import 'package:jntua_world/services/cloudFirestore_services.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController hallTicketCntlr = TextEditingController();

  CloudFiresotreService cfssInstance = CloudFiresotreService();

  Future<Results> res;
  @override
  void initState() {
    super.initState();
    res = cfssInstance.getDataFromFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<Results>(
        future: res,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(snapshot.data.photoUrl),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text('Display Name: ${snapshot.data.displayName}'),
                    Text('Student Name: ${snapshot.data.studentName}'),
                    Text('Hall Ticket No: ${snapshot.data.hallTicketNo}'),
                    CustomRRB(
                      onPressed: () {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("not yet implemented"),
                        ));
                      },
                      txt: 'update',
                      radius: 10,
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
