import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({super.key});

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> _signOut() async {
    await googleSignIn.disconnect();
    Navigator.pushNamed(context, MyRoutes.signUpRoute);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Welcome to My New Project"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(onTap: () {
_signOut();
              Navigator.pushNamed(context, MyRoutes.signUpRoute);
              const snackBar = SnackBar(content: Text("Sign Out Successfuly"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
              ,

              child: Container(
                  height: 55,
                  width: 520,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}