import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studdyapp/styles/constants.dart';

class MyDrawer extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  MyDrawer({super.key});

  Future<String> _getUserName() async {
    final doc = await usersCollection.doc(currentUser.uid).get();
    if (doc.exists) {
      final data = doc.data();
      return data?['UserName'] ?? "Utilisateur";
    } else {
      return "Utilisateur";
    }
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = currentUser.email ?? "Utilisateur";

    return Drawer(
      backgroundColor: kSecondaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder<String>(
            future: _getUserName(),
            builder: (context, snapshot) {
              final userName = snapshot.data ?? "Chargement...";

              return UserAccountsDrawerHeader(
                accountName: Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: kTitleSize,
                  ),
                ),
                accountEmail: Text(
                  userEmail,
                  style: const TextStyle(color: Colors.black),
                ),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text('Profile', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Divider(color: Colors.black, thickness: 1, indent: 16, endIndent: 16),

          ListTile(
            leading: const Icon(Icons.edit, color: Colors.black),
            title: const Text('Tâches', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Divider(color: Colors.black, thickness: 1, indent: 16, endIndent: 16),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
