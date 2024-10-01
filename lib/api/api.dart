import 'package:baatcheet/models/chatuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  // this one is for authentucation
  static FirebaseAuth auth = FirebaseAuth.instance;
  // for accessing cloud firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //for returning current user
  static User get user => auth.currentUser!;
  // for checking if user exists or not
  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  //for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        createdAt: time,
        email: user.email.toString(),
        isOnline: false,
        lastActive: time,
        id: user.uid,
        Image: user.photoURL.toString(),
        pushToken: '',
        Name: user.displayName.toString(),
        About: "Maxuda");
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }
}
