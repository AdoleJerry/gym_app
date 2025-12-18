import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomUser {
  CustomUser({required this.uid, this.email});

  final String uid;
  final String? email;
}

abstract class AuthBase {
  Stream<CustomUser?> get onAuthStateChanged;
  Future<CustomUser?> currentUser();
  Future<void> signOut();
  Future<CustomUser?> signInWithGoogle();
  Future<CustomUser?> signInAnonymously();
  Future<CustomUser?> signInWithEmailAndPassword(String email, String password);
  Future<CustomUser?> createUserWithEmailAndPassword(
    String email,
    String password,
  );
}

class Auth implements AuthBase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CustomUser? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return CustomUser(uid: user.uid, email: user.email);
  }

  @override
  Future<CustomUser?> currentUser() async {
    final user = _auth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Stream<CustomUser?> get onAuthStateChanged {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<CustomUser?> signInAnonymously() async {
    final authResult = await _auth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<CustomUser?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn
        .signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authresult = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authresult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<CustomUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(authResult.user);
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'This user account has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email address.';
          break;
        case 'ERROR_WRONG_PASSWORD':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          errorMessage = 'Too many attempts. Please try again later.';
          break;
        case 'ERROR_NETWORK_REQUEST_FAILED':
          errorMessage =
              'Network error. Please check your internet connection.';
          break;
        case 'ERROR_INVALID_CREDENTIAL':
          errorMessage = 'Invalid credentials provided.';
          break;
        default:
          errorMessage = 'Login failed: ${e.message}';
      }
      throw PlatformException(
        code: e.code,
        message: errorMessage,
        details: e.message,
      );
    }
  }

  @override
  Future<CustomUser?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(authResult.user);
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'An account already exists with this email address.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/password accounts are not enabled.';
          break;
        case 'weak-password':
          errorMessage =
              'The password is too weak. It must be at least 6 characters.';
          break;
        case 'network-request-failed':
          errorMessage =
              'Network error. Please check your internet connection.';
          break;
        default:
          errorMessage = 'Registration failed: ${e.message}';
      }

      throw PlatformException(
        code: e.code,
        message: errorMessage,
        details: e.message,
      );
    } catch (e) {
      // Handle any other exceptions
      throw PlatformException(
        code: 'UNKNOWN_ERROR',
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _auth.signOut();
  }
}
