import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../main.dart';
import 'account_page.dart';
import 'account_creation_page.dart';

// TODO add firebase, including email + password and Google login capabilities
FirebaseAuth auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Roboto')),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (_) => AccountPage()));
                  },
                  child: Text(
                    'Sign up with Email',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (_) => AccountPage()));
                  },
                  child: Text(
                    'Sign up with Google',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),

            Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                    child: Text("Already a user? Log In",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountCreation()),
                      );
                    }))
          ]),
        ));
  }}