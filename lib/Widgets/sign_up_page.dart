import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:capi_stonsker/nav/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'account_page.dart';
import 'email_creation_page.dart';
import 'package:capi_stonsker/src/fire_auth.dart';
import 'log_in_page.dart';


class SignUp extends StatefulWidget {

  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
                    fontWeight: FontWeight.bold)),
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
              child: Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                try {
                await FireAuth.signInWithGoogle(context: context) ;

                Navigator.of(context).pop();
                Navigator.of(context).pop();
                
                } on FirebaseAuthException catch (e) {
                  showDialog(
                    context: context,
                    builder: (ctx) =>
                        AlertDialog(
                          title: Text("Login Failed. Please try again."),
                          content: Text('${e.message}'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: Text('Okay'),
                            )
                          ],
                        ),
                  );
                  print(e);
                }
                },
                  child: Text(
                    'Log in with Google',
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
                    }))
          ]),
        ),
        drawer: SideMenu(),
        bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }}