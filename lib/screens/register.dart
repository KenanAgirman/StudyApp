import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studdyapp/authentification/firebase_auth.dart';
import 'package:studdyapp/components/error_handler.dart';
import 'package:studdyapp/components/my_buttton.dart';
import 'package:studdyapp/components/my_textfield.dart';
import 'package:studdyapp/screens/login.dart';
import 'package:studdyapp/styles/constants.dart';



final FirebaseFirestore firestore = FirebaseFirestore.instance;


Future<void> createUser(String userId,String email,String UserName)async{
  await firestore.collection('users').doc(userId).set({
    'email':email,
    'UserName':UserName,
    'createdAt': FieldValue.serverTimestamp(),
  });
}



class Register extends StatefulWidget {
  static const routeName = '/register';

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  void signUserIn() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmpasswordController.text.trim();
    final userName = userController.text.trim();



    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || userName.isEmpty) {
      ErrorHandler.showError(context, "Tous les champs sont obligatoires.");
      return;
    }

    if (password != confirmPassword) {
      ErrorHandler.showError(context,"Les mots de passe ne correspondent pas");
      return;
    }

    if(password.length< 6){
      ErrorHandler.showError(context,"Password should be at least 6 characters");

    }

    try {
      User? user = await signUp(email, password);

      if (user != null) {
        ErrorHandler.showError(context,"Inscription réussie ! Utilisateur : ${user.email}");
        await createUser(user.uid, email, userName);

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        print("Erreur lors de l'inscription");
      }
    } catch (e) {
      String errorMessage = '';

      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-credential') {
          errorMessage = 'soit votre email, votre mot de passe ou les deux sont incorrects';
        } else {
          errorMessage = '${e.message}';
        }
      } else {
        errorMessage = '$e';
      }


      ErrorHandler.showError(context, errorMessage);
    }
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
                  width: kLogoSize,
                  height: kLogoSize,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Logo2.png'),
                    ),
                  ),
                ),
                MyTextField(hintext: 'Nom', obscureText: false, iconData: Icons.person, controller: userController),
                const SizedBox(height: kVerticalPaddingL),

                MyTextField(hintext: 'Adresse email', obscureText: false, iconData: Icons.mail, controller: emailController),
                const SizedBox(height: kVerticalPaddingL),

                MyTextField(hintext: 'Mot de passe', obscureText: true, iconData: Icons.lock, controller: passwordController),
                const SizedBox(height: kVerticalPaddingL),

                MyTextField(hintext: 'Confirmez le mot de passe', obscureText: true, iconData: Icons.lock, controller: confirmpasswordController),
                const SizedBox(height: kVerticalPaddingL),

                MyButton(text: 'Inscription', onTap: signUserIn),
                const SizedBox(height: kVerticalPaddingL),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Déjà un compte? ", style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Login.routeName),
                      child: const Text(
                        "Connectez-vous",
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
