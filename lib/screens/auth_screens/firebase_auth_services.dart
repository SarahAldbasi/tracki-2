import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant/model/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _currentUserId = "";

  // Set current user ID
  void setCurrentUserId(String newUserId) {
    _currentUserId = newUserId;
  }

  // Get current user ID
  String get currentUserId {
    return _currentUserId;
  }

  // Clear current user ID
  void clearCurrentUser() {
    _currentUserId = "";
  }

  // Get user details from Firestore
  Future<UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    setCurrentUserId(currentUser.uid);
    if (kDebugMode) {
      print("User data: ${snap.data().toString()}");
    }
    return UserModel.fromSnap(snap);
  }

  // Sign-up user using email, password, and userName
  Future<String> signUpUser({
    required String password,
    required String userName,
    required String email,
  }) async {
    String res = "Some error occurred";
    try {
      if (userName.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // Create user in Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Create user model for Firestore
        UserModel user = UserModel(
          uid: userCredential.user!.uid,
          userName: userName,
          email: email,
        );

        // Save user data in Firestore
        await _firestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());

        res = "User created successfully";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Login user with email and password
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Sign out user
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
      clearCurrentUser();
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
