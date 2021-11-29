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
        automaticallyImplyLeading: false,
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
                                (context) => AccountPage()),
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