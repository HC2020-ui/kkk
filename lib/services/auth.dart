import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseRefrence=FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn=GoogleSignIn();

  // ignore: deprecated_member_use
  UserData _userformfirebase(auth.User user) {
    return user != null ? UserData(id: user.uid) : null;
  }

  Stream<UserData> get user {
    // ignore: deprecated_member_use
    return _auth.onAuthStateChanged
        .map((auth.User user) => _userformfirebase(user));
  }

  Future signinwithgoogle() async {
    FirebaseUser firebaseUser;
    bool isSignedIn=await _googleSignIn.isSignedIn();
    if(isSignedIn){
      firebaseUser= await _auth.currentUser;
    }else{
      final GoogleSignInAccount googleuser= await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth= await googleuser.authentication;
      final AuthCredential credential= GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      firebaseUser=(await _auth.signInWithCredential(credential)).user;
      return firebaseUser;
    }
  }
}