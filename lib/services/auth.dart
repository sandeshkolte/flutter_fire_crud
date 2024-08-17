import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/models/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users? _userFromFirebaseUser(User user) {
    //FirebaseUser name changed to User
    return Users(userId: user.uid);
    }

  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          //AuthResult name changed to UserCredential
          email: email,
          password: password);
      User firebaseUser = result.user as User;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user as User;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future devicesignOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
