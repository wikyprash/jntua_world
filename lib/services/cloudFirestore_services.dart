import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFiresotreService {
  final String uid;
  CloudFiresotreService({this.uid});

  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future setNewuserData() async {
    final _currentUser = await _auth.currentUser();
    final _docRef = userCollection.document(uid);
    _docRef.get().then(
      (docData) {
        if (!docData.exists) {
          print('setNewuserData');
          _docRef.setData({
            'userAccountDetails': {
              'displayName': _currentUser.displayName,
              'email': _currentUser.email,
              'photoUrl': _currentUser.photoUrl,
              'phoneNumber': _currentUser.phoneNumber,
              'isEmailVerified': _currentUser.isEmailVerified
            }
          });
        } else {
          print(docData.data);
        }
      },
    );
  }

  Future updateUserResultsData(String resultsData) async {
    return await userCollection.document(uid).setData(
        {'Student name': '', 'Hall Ticket No': '', 'resultsData': resultsData});
  }
}
