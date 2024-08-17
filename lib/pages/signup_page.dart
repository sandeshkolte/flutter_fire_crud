import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/utils/round_button.dart';
import 'package:flutter_fire_crud/utils/util.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> _signIn() async {
    try {
      await googleSignIn.signIn();
      await Navigator.pushNamed(context, MyRoutes.signOutRoute);
      const snackBar = SnackBar(content: Text("Signed in Successfuly"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      print("Sign in error: $error");
    }
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confpassController = TextEditingController();

  devicesignUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).canvasColor,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.lock, size: 50),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Let's create an account for you !",
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
                        color: Theme.of(context).canvasColor),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is empty';
                          }
                          return null;
                        },
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
                        color: Theme.of(context).canvasColor),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is empty';
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: passController,
                        decoration: const InputDecoration(
                            hintText: "Password", border: InputBorder.none),
                      ),
                    )),
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
                      color: Theme.of(context).canvasColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        obscureText: true,
                        controller: confpassController,
                        decoration: const InputDecoration(
                            hintText: "Confirm Password",
                            border: InputBorder.none),
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundButton(title: "Sign up", onTap: () {
                  if (_formKey.currentState!.validate()) {
                      _auth
                          .createUserWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passController.text.toString())
                          .then((value) => null)
                          .onError((error, stackTrace) {
                        Util().toastMessage(error.toString());
                      });
                    }
                })
              ),
              const SizedBox(
                height: 45,
              ),
              Center(
                child: Text(
                  "Or continue with",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: _signIn,
                    child: Image.asset(
                      "assets/images/google_logo.webp",
                      height: 80,
                      width: 80,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      const snackBar = SnackBar(
                          content: Text("Not added IOS functionality yet!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Image.asset(
                      "assets/images/ios_logo.png",
                      height: 100,
                      width: 100,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account? ",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                    },
                    child: const Text(
                      "Login now",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
