import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studdyapp/screens/home.dart';
import 'package:studdyapp/screens/login.dart';



class AuthVerification extends StatelessWidget {
  static const routeName = '/';

  const AuthVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const Home();
          }
          else{
            return Login();
          }
        },
      ),
    );
  }
}

