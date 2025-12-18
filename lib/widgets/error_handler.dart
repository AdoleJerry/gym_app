import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthErrorHandler {
  static void showAuthError(BuildContext context, dynamic error) {
    String errorMessage = 'Authentication failed';

    if (error is PlatformException) {
      errorMessage = _getErrorMessageFromPlatformException(error);
    } else if (error is FirebaseAuthException) {
      errorMessage = _getErrorMessageFromFirebaseException(error);
    } else if (error is String) {
      errorMessage = error;
    } else {
      errorMessage = error.toString();
    }

    _showSnackBar(context, errorMessage);
  }

  static String _getErrorMessageFromPlatformException(PlatformException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'invalid-credential':
        return 'Invalid credentials provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak. It must be at least 6 characters.';
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
        return 'Google authentication failed. Missing token.';
      case 'ERROR_ABORTED_BY_USER':
        return 'Sign in was cancelled.';
      case 'UNKNOWN_ERROR':
        return e.message ?? 'An unexpected error occurred.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }

  static String _getErrorMessageFromFirebaseException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'invalid-credential':
        return 'Invalid credentials provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak. It must be at least 6 characters.';
      default:
        return e.message ?? 'Authentication failed.';
    }
  }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
