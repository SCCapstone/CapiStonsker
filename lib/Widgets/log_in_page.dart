import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// import '../main.dart';
import 'account_page.dart';
import 'account_creation_page.dart';

// TODO add firebase, including email + password and Google login capabilities
FirebaseAuth auth = FirebaseAuth.instance;

class LogIn extends StatefulWidget {
  @override
  _LogIn createState() => _LogIn();
}

class _LogIn extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              // TODO consider changing these static padding dynamic values to dynamic?
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:15.0,bottom: 0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            Padding(
              // TODO consider changing these static padding dynamic values to dynamic?
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Forgot Password?',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:
                                (context) => const AccountScreen()),
                          ); //TODO integrate forgot password screen
                        }
                  ),


                ]
                )),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(
                      context, MaterialPageRoute(builder: (_) => AccountPage()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'New User? Create Account',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder:
                                (context) => const AccountCreation()),
                          );
                        }
                  ),


                ]
                ))
            // TODO add link to create account page + Log in with Google, etc
          ],
        ),
      ),
    );
  }
}



// FirebaseAuth.instance.authStateChanges().listen((User? user) {
//   if (user == null) {
//     print('User is currently signed out!');
//   } else {
//     print('User is signed in!');
//   }
// });
//
// FirebaseAuth.instance.idTokenChanges().listen((User? user) {
//   if (user == null) {
//     print('User is currently signed out!');
//   } else {
//     print('User is signed in!');
//   }
// });
//
// FirebaseAuth.instance.userChanges().listen((User? user) {
//   if (user == null) {
//     print('User is currently signed out!');
//   } else {
//     print('User is signed in!');
//   }
// });
//
// UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
//
// void createUserWithEmailAndPassword() async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(
//         email: "barry.allen@example.com",
//         password: "SuperSecretPassword!"
//     );
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The password provided is too weak.');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//   } catch (e) {
//     print(e);
//   }
// }
//
// void signInWithEmailAndPassword() async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: "barry.allen@example.com",
//         password: "SuperSecretPassword!"
//     );
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       print('No user found for that email.');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user.');
//     }
//   }
// }