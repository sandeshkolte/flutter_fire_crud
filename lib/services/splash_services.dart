import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/firestore/firestore_screen.dart';
import 'package:flutter_fire_crud/pages/loginpage.dart';

class SplashServices {
  isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FirestorePost_Screen()));
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      });
    }
  }
}
