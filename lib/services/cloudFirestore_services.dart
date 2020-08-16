import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFiresotreService {

  final String uid;
  
  CloudFiresotreService(this.uid);

  final CollectionReference  userCollection = Firestore.instance.collection('users');

  Future updateUserData(String resultsData) async {
    return await userCollection.document(uid).setData({
      'Student name' : '',
      'Hall Ticket No' : '',
      'resultsData' : resultsData
    });
  }
}
