import 'package:firebase_auth/firebase_auth.dart';


final FirebaseAuth auth = FirebaseAuth.instance;

// Inscription
Future<User?> signUp(String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    print('Erreur inscription : $e');
    return null;
  }
}

// Connexion
Future<User?> signIn(String email, String password) async {
  try {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  } on FirebaseAuthException catch (e) {
    print('Erreur connexion : $e');
    return null;
  }
}

// Déconnexion
Future<void> signOut() async {
  await auth.signOut();
}




