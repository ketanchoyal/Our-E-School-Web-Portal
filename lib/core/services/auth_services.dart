import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:oureschoolweb/core/enums/auth_results.dart';
import 'package:oureschoolweb/core/services/exceptions.dart';
import 'package:oureschoolweb/core/services/services.dart';

@singleton
class AuthServices extends Services {
  signIn(
    String email,
    String password,
  ) async {
    try {
      await auth().signInWithEmailAndPassword(email: email, password: password);
      if (getFirebaseUser() != null) {
        return FirebaseAuthResults.SUCCESS;
      } else {
        return FirebaseAuthResults.UNKNOWN;
      }
    } catch (e) {
      FirebaseAuthException.catchException(e);
    }
  }

  register(
    String email,
    String password,
    String schoolCode,
  ) async {
    try {
      bool userValid = await _checkIfSchoolAndAdminExists(schoolCode, email);
      if (userValid) {
        await auth()
            .createUserWithEmailAndPassword(email: email, password: password);
        if (getFirebaseUser() != null) {
          return FirebaseAuthResults.SUCCESS;
        } else {
          return FirebaseAuthResults.UNKNOWN;
        }
      } else {
        return FirebaseAuthException.catchException(
            new PlatformException(code: "1", message: "1"));
      }
    } catch (e) {
      FirebaseAuthException.catchException(e);
    }
  }

  _checkIfSchoolAndAdminExists(
    String schoolCode,
    String email,
  ) async {
    DocumentReference _schoolLoginRef =
        webCollectionRef.document(schoolCode.toUpperCase().trim());

    DocumentSnapshot snapshot = await _schoolLoginRef.get();

    if (snapshot.exists) {
      var adminEmails = snapshot['schoolAdmin'] as List;
      debugPrint(adminEmails.toString());
      return adminEmails.contains(email);
    } else {
      return snapshot.exists;
    }
  }
}
