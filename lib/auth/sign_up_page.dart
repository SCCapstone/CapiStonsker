/*
 * The sign up page connects to Firebase and allows the user to create an account
 */

import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'email_creation_page.dart';
import 'log_in_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;
class SignUp extends StatefulWidget {

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }
        ),
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
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountCreation()),
                  );
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
              child: GestureDetector(
                  child: Text("Already a user? Log In",
                      style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          color: Colors.blue)),
                  onTap: () {
                    //popUntil account
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: RouteSettings(name: "/login"),
                          builder: (context) => LoginScreen()),
                    );
                  })
          )
        ]
        ),
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}