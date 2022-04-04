/*
 * This page provides Firebase user authentication functionality,
 * which includes signing in or creating an account using
 * an email and password
 *
 * These functions are implemented on the log_in_page and
 * account_creation_page
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User? user;

  // This method allows a new user to sign up with email and password
  static Future<FirebaseAuthException?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCred.user;
      FirebaseFirestore.instance
          .collection('Users')
          .doc(user?.uid)
          .set(<String, dynamic>{
        "email": user?.email,
      });
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('Account already exists for that email.');
      }
      return e;
    }
    catch (e) {
      print(e);
    }
    return null;
  }

  // This method allows a returning user to sign in using their email and password
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      //Retrieves wishlist and visited list
      locs.getWish();
      locs.getVis();
      //createListener();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Password is incorrect');
      }
    }

    //return user;
  }

  static Future<String> getEmail() async {
    return (await auth.currentUser)!.email!;
  }

  static Future<String> getName() async {
    if (auth.currentUser!.displayName != null && auth.currentUser!.displayName != "")
      return (await auth.currentUser)!.displayName!;
    else
      return (await auth.currentUser)!.email!;
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
    //Clear user collection lists
    locs.wishlistID = [];
    locs.wishlist = [];
    locs.visitedID = [];
    locs.visited = [];
  }

  static Future<int> visitedAmount() async {
    return FirebaseFirestore.instance
        .collection('Visited')
        .snapshots()
        .length;
  }

  static Future<String> getBio() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FireAuth.auth.currentUser!.uid)
        .get();
    return snapshot.get("bio");
  }

  static String getBadge() {
    int amount = locs.visited.length.toInt();
    String badge="";
    if(amount>=0&&amount<=414){
      badge="Novice";
    }
    if(amount>=415&&amount<=1034){
      badge="Intermediate";
    }
    if(amount>=1035&&amount<=2064){
      badge="Advanced";
    }
    if(amount>=2065&&amount<=3094){
      badge="Expert";
    }
    if(amount>=3095&&amount<=4130){
      badge="Legend";
    }
    if(amount==4131){
      badge="Capistonktastic";
    }
    return badge;
  }
}