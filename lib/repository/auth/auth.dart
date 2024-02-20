import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> signInwithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      return true;
    } else {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      return false;
    }
  }

  bool autenticate() {
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      return true;
    } else {
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      return false;
    }
  }

  bool inSession() {
    if (FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.emailVerified) {
      return true;
    } else {
      return false;
    }
  }
}
