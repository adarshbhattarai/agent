import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../logger/log_printer.dart';
import '../user/user.dart';


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final logger = Logger(printer: SimpleLogPrinter('AuthenticationFlowScreen: '),
     level: Level.all);

  /// create user
  Future<UserModel?> signUpUser(
    String email,
    String password,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      logger.e(e.toString());
    }
    return null;
  } 

   ///signOutUser 
   Future<void> signOutUser() async {
      final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  ///signInUser 
   Future<UserModel?> signInUser(
    String email,
    String password,
   ) async {    
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
        logger.e(e.message);
    }
    return null;
  }
}