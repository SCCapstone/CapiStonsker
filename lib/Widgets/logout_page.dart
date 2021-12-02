import 'package:capi_stonsker/nav/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'side_menu.dart';
import 'sign_up_page.dart';

//TODO this is quite literally just a page to log out, for testing purposes.
// It is basic functionality. It will be improved in the beta release

class LogoutPage extends StatelessWidget {
  LogoutPage({Key? key}) : super(key: key);
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
        title: Text("Log Out"),
        backgroundColor: Colors.blueGrey,
      ),
        body:
            Center(
          child: LoginSignupButton(
            title: 'Log Out',
            ontapp: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => SignUp()
                  )
              );
            }

          ),
        ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}



class LoginSignupButton extends StatelessWidget {
  final String title;
  final dynamic  ontapp;

  LoginSignupButton({required this.title, required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed:
          ontapp,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}