import 'package:flutter/material.dart';
import 'package:studdyapp/styles/constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintext;
  final bool obscureText;
  final IconData iconData;

  const MyTextField({
    super.key,
    this.controller,
    required this.hintext,
    required this.obscureText,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingValue),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(iconData, color: Colors.black),
          hintText: hintext,
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(kRadiusSize),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(kRadiusSize),
          ),
          fillColor: kSecondaryColor,
          filled: true,
        ),
      ),
    );
  }
}