import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/main.dart';
import 'package:flutter_fire_crud/pages/login_with_phone.dart';
import 'package:flutter_fire_crud/utils/sign_button.dart';
import 'package:flutter_fire_crud/utils/util.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../firestore/firestore_screen.dart';
import '../utils/round_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    try {
      await googleSignIn.signIn();
      const snackBar = SnackBar(content: Text("Signed in Successfuly"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => const FirestorePost_Screen())));
    } catch (error) {
      print("Sign in error: $error");
    }
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).canvasColor,
        body: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.lock, size: 80),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Welcome back you've been missed !",
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Theme.of(context).primaryColorLight)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 55,
                    width: 520,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).primaryColorLight,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: "Email", border: InputBorder.none),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: Container(
                    height: 55,
                    width: 520,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).primaryColorLight,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passController,
                        decoration: const InputDecoration(
                            hintText: "Password", border: InputBorder.none),
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Forgot Password?",
                      style:
                          TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundButton(
                      title: "Sign in",
                      onTap: () {
                        _auth
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passController.text.toString())
                            .then((value) {
                          Util().toastMessage(
                              "Signed in with\n ${value.user!.email}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const FirestorePost_Screen())));
                        }).onError((error, stackTrace) =>
                                Util().toastMessage(error.toString()));
                      })),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: Text(
                  "Or continue with",
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SignButton(title: 'Sign in with Google', onTap: _signIn),
              const SizedBox(
                height: 20,
              ),
              SignButton(
                  title: 'Sign in with IOS',
                  onTap: () {
                    const snackbar = SnackBar(
                      content: Text('IOS funtionality not added yet !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }),
              const SizedBox(
                height: 20,
              ),
              SignButton(
                  title: 'Login with phone',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPhone()));
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member? ",
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.signUpRoute);
                    },
                    child: const Text(
                      "Register now",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
