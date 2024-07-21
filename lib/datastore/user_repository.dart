import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/user/user.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> storeUserDetails(UserModel user, String agentName) async {
    CollectionReference users = _firestore.collection('users');

    return users
        .doc(user.id)
        .set({
          'agentName': agentName,
          'company': user.displayName,
          'email': user.email,
        })
        .then((value) => print("User Details Added"))
        .catchError((error) => print("Failed to add user details: $error"));
  }
}
