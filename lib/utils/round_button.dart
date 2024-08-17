import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
   RoundButton({super.key, required this.title,required this.onTap});
  final String title;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
      child: Container(
          height: 55,
          width: 520,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.black,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5),
            ),
          )),
    );
  }
}
