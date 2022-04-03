/*
 * This page provides Firebase user authentication functionality,
 * which includes signing in or creating an account using
 * an email and password as well as Google sign in
 *
 * These functions are implemented on the log_in_page and
 * account_creation_page
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:google_sign_in/google_sign_in.dart';

//FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();


class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User? user;
  late String bio;


  // This method allows a new user to sign up with email and password
  static Future<User?> registerUsingEmailPassword({
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
    }
    catch (e) {
      print(e);
    }
    return user;
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

  //TODO Add list retrieves and friend subscription
  // This method allows a user to sign in using their Google account
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print('Incorrect credentials.');
        }
        else if (e.code == 'invalid-credential') {
          print('Invalid credentials');
        }
      }
    }

    return user;
  }

  static Future<String> getEmail() async {
    return (await auth.currentUser)!.email!;
  }

  static Future<String> getName() async {
    if (auth.currentUser!.displayName != null) {
      return (await auth.currentUser)!.displayName!;
    }
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
}