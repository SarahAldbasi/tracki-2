import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String userName;
  final String email;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
  });

  // Convert a UserModel instance to a JSON object (Firestore data format)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
    };
  }

  // Create a UserModel instance from a Firestore snapshot
  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      userName: snapshot['userName'],
      email: snapshot['email'],
    );
  }
}
