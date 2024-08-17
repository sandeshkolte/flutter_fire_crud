import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        canvasColor:
            // const Color.fromARGB(255, 234, 234, 234),
            Colors.white,
        primaryColor: Colors.white,
        primaryColorLight: Colors.black54,
        primaryColorDark: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 234, 234, 234),
          foregroundColor: Colors.black54,
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        canvasColor: Colors.white10,
        primaryColor: Colors.black,
        primaryColorLight: Colors.white70,
        primaryColorDark: Colors.white70,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black54,
          foregroundColor: Colors.white,
        ),
      );
}
