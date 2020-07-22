import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:oureschoolweb/app/locator.dart';
import 'package:oureschoolweb/core/services/shared_preference.dart';

@singleton
class Services {
  SharedPreferencesHelper _sharedPreferencesHelper = locator<
      SharedPreferencesHelper>(); //Get this from firstScreen(UI Not developed yet)
  FirebaseAuth _auth = FirebaseAuth.instance;

  Firestore _firestore() => Firestore.instance;

  FirebaseUser _firebaseUser;

  // User _user;

  // String schoolCode;

  CollectionReference _webCollectionRef() => _firestore().collection('Web');

  Firestore firestore() => _firestore();
  FirebaseAuth auth() => _auth;

  CollectionReference get webCollectionRef => _webCollectionRef();

  Future<DocumentReference> schoolRefwithCode() async => _webCollectionRef()
      .document((await getSchoolCode()).toUpperCase().trim());

  SharedPreferencesHelper get sharedPreferencesHelper =>
      _sharedPreferencesHelper;

  getFirebaseUser() async {
    _firebaseUser = await _auth.currentUser();
  }

  Future<String> getSchoolCode() async {
    return await _sharedPreferencesHelper.getSchoolCode();
  }

  setSchoolCode(String schoolCode) async {
    return await _sharedPreferencesHelper.setSchoolCode(schoolCode);
  }
}
