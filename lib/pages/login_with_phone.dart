import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/utils/round_button.dart';

import '../utils/util.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LofinPhgneState();
}

class _LofinPhgneState extends State<LoginPhone> {
  final phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(hintText: "+91 345 383 7328"),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          RoundButton(
              title: "Verify",
              onTap: () {
                auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text.toString(),
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      Util().toastMessage(e.toString());
                    },
                    codeSent: ((verificationId, forceResendingToken) {
                      
                    }),
                    codeAutoRetrievalTimeout: (e) {
                      Util().toastMessage(e.toString());
                    });
              })
        ],
      ),
    );
  }
}
