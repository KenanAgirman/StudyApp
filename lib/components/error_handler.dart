import 'package:flutter/material.dart';
import 'package:studdyapp/error/error_firebase_auth.dart';

class ErrorHandler {
  static void showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static void handleFirebaseAuthError(BuildContext context, dynamic error) {
    final code = error.code ?? '';
    final message = firebaseErrors[code] ?? 'Une erreur est survenue.';
    showError(context, message);
  }
}