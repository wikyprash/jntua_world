import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jntua_world/models/userDocumentModel.dart';
import 'package:jntua_world/services/api_services.dart';

class CloudFiresotreService {

  DocumentReference getDoc(String uid) {
    final docRef = Firestore.instance.collection("users").document(uid);
    return docRef;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future setNewuserData(String uid) async {
    final _currentUser = await _auth.currentUser();
    final _docRef = getDoc(uid);
    _docRef.get().then(
      (docData) {
        if (!docData.exists) {
          print('setting new user : setNewuserData()');
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

  Future<UserDocumentModel> customUserDocumentObject(String uid) async {
    var data = await getDoc(uid).get();
    var enk = JsonEncoder().convert(data.data);
    final userDocumentModel = userDocumentModelFromJson(enk);
    return userDocumentModel;
  }

  Future<void> updateUserResultsData(String rollno, String uid) async {
    Map json = await ApiServices().getDataFromAPI(rollno);
    final String studentName = json['user']['Student name'];
    final String hallTicketNo = json['user']['Hall Ticket No'];
    final List resData = json['results'];
    print('updateUserResultsData to $uid');
    await getDoc(uid).updateData({
      'results': {
        'Student name': studentName,
        'Hall Ticket No': hallTicketNo,
        'resultsData': resData
      }
    });
  }

  Future<void> deleteUserResult(String uid) async{
    getDoc(uid).updateData({
      'results' : FieldValue.delete()
    }).whenComplete(() => print('results deleted!!!'));
  }
}
