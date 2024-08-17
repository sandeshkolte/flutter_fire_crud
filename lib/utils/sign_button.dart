import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  SignButton({super.key, required this.title, required this.onTap});
  final String title;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 520,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Theme.of(context).primaryColorDark)),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontSize: 17, color: Theme.of(context).primaryColorDark),
        )),
      ),
    );
  }
}
