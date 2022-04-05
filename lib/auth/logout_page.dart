/*
 * This is quite literally just a page to log out, for testing purposes.
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/auth/log_in_page.dart';
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/auth/fire_auth.dart';

class LogoutPage extends StatelessWidget {
  LogoutPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
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
          child: logoutButton(context),
        ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }

  Widget logoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: (() {
            FireAuth.signOut();
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()
                )
            );
          }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Log Out",
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