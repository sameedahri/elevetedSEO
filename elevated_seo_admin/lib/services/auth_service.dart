import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elevated_seo_admin/models/admin_model.dart';
import 'package:elevated_seo_admin/models/users_model.dart';
import 'package:elevated_seo_admin/screens/main_screen.dart';
import 'package:elevated_seo_admin/utils/constants.dart';
import 'package:elevated_seo_admin/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Streams
Stream<List<AdminModel>> get getAdmins {
  return adminRef.snapshots().map(
      (event) => event.docs.map((e) => AdminModel.fromJson(e.data())).toList());
}

Stream<List<GMBUser>> get getUsers {
  return userRef.snapshots().map(
      (event) => event.docs.map((e) => GMBUser.fromMap(e.data())).toList());
}

Future<void> deleteUser(GMBUser gmbUser) {
  return userRef.doc(gmbUser.uid).delete();
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addNewUser(String email, String pass, String name) async {
    try {
      final UserCredential authResult = await _auth
          .createUserWithEmailAndPassword(email: email, password: pass);

      final User firebaseUser = authResult.user;

      if (firebaseUser != null)
        return userRef.doc(firebaseUser.uid).set(GMBUser(
              email: email,
              accountName: name,
              uid: firebaseUser.uid,
            ).toMap());
    } catch (e) {}
  }

  Future<void> saveAdminData(AdminModel admin) {
    return adminRef.doc(admin.emailAddress).set(admin.toMap());
  }

  login(String email, String password, BuildContext context) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        DocumentSnapshot doc = await adminRef.doc(email).get();

        if (doc.exists) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        } else {
          showMessage("You are not authorized to login into the admin panel.");
        }
      }
    } catch (e) {
      showMessage(e.toString());
    }
  }

  changePassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showMessage('Password Reset mail has been sent to $email');
    } catch (e) {
      showMessage(e.toString());
    }
  }
}
