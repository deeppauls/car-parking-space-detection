import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUser(
      {required String email, required String password}) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password).whenComplete(() => print("user created"));
    print(user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Future<User?> signUpWithEmailAndPassword(String email, String password) async {

  //   try {
  //     UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     return credential.user;
  //   } on FirebaseAuthException catch (e) {

  //     if (e.code == 'email-already-in-use') {
  //       print( 'The email address is already in use.');
  //     } else {
  //       print( 'An error occurred: ${e.code}');
  //     }
  //   }
  //   return null;

  // }

  // Future<User?> signInWithEmailAndPassword(String email, String password) async {

  //   try {
  //     UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     return credential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found' || e.code == 'wrong-password') {
  //       print( 'Invalid email or password.');
  //     } else {
  //   print( 'An error occurred: ${e.code}');
  //     }

  //   }
  //   return null;

  // }
}
