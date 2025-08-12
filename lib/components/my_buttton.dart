import 'package:flutter/material.dart';
import 'package:studdyapp/styles/constants.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(kPaddingValue),
        margin: const EdgeInsets.symmetric(horizontal: kPaddingValue),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(kRadiusSize),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: (kPrimaryColor),
              fontWeight: FontWeight.bold,
              fontSize: kNormalSize,
            ),

          ),
        ),
      ),
    );
  }
}
