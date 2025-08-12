import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studdyapp/styles/constants.dart';

class HeaderHome extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  HeaderHome({super.key});

  Future<String> _getUserName() async {
    final doc = await usersCollection.doc(currentUser.uid).get();

    if (doc.exists) {
      final data = doc.data();
      print("DATA FIRESTORE: $data");

      if (data != null && data.containsKey('UserName')) {
        return data['UserName']; // ✅ ici majuscule
      } else {
        return 'Champ UserName manquant';
      }
    }
    return 'Document inexistant';
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: kAccentColor,
      padding: const EdgeInsets.all(kPaddingValue),
      child: FutureBuilder<String>(
        future: _getUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError) {
            return const Text('Erreur lors du chargement', style: TextStyle(color: Colors.white));
          } else {
            final userName = snapshot.data ?? 'Utilisateur';
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Bienvenue $userName',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text('Tâches à faire : 5', style: TextStyle(fontSize: kNormalSize, color: Colors.white)),
                const SizedBox(height: 8),
                const Text('Tâches terminées : 3', style: TextStyle(fontSize: kNormalSize, color: Colors.white)),
              ],
            );
          }
        },
      ),
    );
  }
}

