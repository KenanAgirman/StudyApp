import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studdyapp/components/error_handler.dart';
import 'package:studdyapp/components/my_buttton.dart';
import 'package:studdyapp/components/my_textfield.dart';
import 'package:studdyapp/screens/home.dart';
import 'package:studdyapp/screens/register.dart';
import 'package:studdyapp/styles/constants.dart';


final FirebaseFirestore firestore = FirebaseFirestore.instance;


class Login extends StatefulWidget {
  static const routeName = '/login';

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signUserIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ErrorHandler.showError(context, "Veuillez remplir tous les champs");
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushNamed(context, Home.routeName);
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "Aucun utilisateur trouvé avec cet email.";
          break;
        case 'wrong-password':
          errorMessage = "Mot de passe incorrect.";
          break;
        case 'user-disabled':
          errorMessage = "Votre compte a été désactivé.";
          break;
        default:
          errorMessage = e.message ?? "Une erreur est survenue.";
      }

      ErrorHandler.showError(context, errorMessage);
    } catch (e) {
      ErrorHandler.showError(context, "Erreur inconnue : $e");
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Logo2.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                MyTextField(
                  controller: emailController,
                  hintext: 'Adresse email',
                  obscureText: false,
                  iconData: Icons.email,
                ),
                const SizedBox(height: kVerticalPaddingL),
                MyTextField(
                  controller: passwordController,
                  hintext: 'Mot de passe',
                  obscureText: true,
                  iconData: Icons.lock,
                ),
                const SizedBox(height: kVerticalPaddingL),
                MyButton(
                  text: 'Connexion',
                  onTap: () => signUserIn(),
                ),
                const SizedBox(height: kVerticalPaddingL),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Vous n'avez pas de compte ? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Register.routeName),
                      child: const Text(
                        "Inscrivez-vous",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
