
import 'package:flutter/material.dart';
import 'package:studdyapp/authentification/auth_verification.dart';
import 'package:studdyapp/screens/home.dart';
import 'package:studdyapp/screens/login.dart';
import 'package:studdyapp/screens/register.dart';

Map<String,WidgetBuilder> routes ={
  AuthVerification.routeName : (context) => const AuthVerification(),
  Login.routeName:(context)=> Login(),
  Register.routeName:(context)=> Register(),
  Home.routeName:(context)=> const Home(),

};