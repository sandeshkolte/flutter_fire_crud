import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_crud/firebase_options.dart';
import 'package:flutter_fire_crud/pages/loginpage.dart';
import 'package:flutter_fire_crud/pages/signout_page.dart';
import 'package:flutter_fire_crud/pages/signup_page.dart';
import 'package:flutter_fire_crud/ui/posts/splash_screen.dart';
import 'package:flutter_fire_crud/ui/posts/themes/theme.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GoogleSignIn googleSignIn = GoogleSignIn();

  late GoogleSignInAccount? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = googleSignIn.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Themes.lightTheme(context),
      darkTheme: Themes.darkTheme(context),
      routes: {
        "/": (context) => const SplashScreen(),
        MyRoutes.signUpRoute: (context) => const SignUpPage(),
        MyRoutes.signOutRoute: (context) => const SignOutPage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
      },
    );
  }
}

class MyRoutes {
  static String signUpRoute = "/signUp";
  static String signOutRoute = "/signOut";
  static String loginRoute = "/login";
}
