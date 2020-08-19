import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jntua_world/models/results.dart';
import 'package:jntua_world/services/api_services.dart';

class CloudFiresotreService {
  final String uid;
  CloudFiresotreService({this.uid});

  final CollectionReference userCollection = Firestore.instance.collection('users');
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
  
  Future<Results> getDataFromFirestore() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    var docRef =
        Firestore.instance.collection("users").document(firebaseUser.uid);
    var data = await docRef.get();
    return Results.fromJson(data.data);
  }
  
  Future updateUserResultsData(String rollno, String uid) async {
    Map json = await getDataFromAPI(rollno);
    final String studentName = json['user']['Student name'];
    final String hallTicketNo = json['user']['Hall Ticket No'];
    final List resData = json['results'];

    return await userCollection.document(uid).updateData({
      'results': {
        'Student name': studentName,
        'Hall Ticket No': hallTicketNo,
        'resultsData': resData
      }
    });
  }
}
