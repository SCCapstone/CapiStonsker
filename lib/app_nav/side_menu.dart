/*
 * The side menu, accessible at all times from the menu button at the
 * left of the bottom menu bar, allows a user to navigate throughout the app
 *
 * TODO pull user name, level, avatar, etc from Firebase to display at the top of the header.
 */

import 'package:capi_stonsker/user_collections/my_markers_page.dart';
import 'package:capi_stonsker/routing/plan_route_page.dart';
import 'package:capi_stonsker/user_collections/wishlist_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/account_page.dart';
import '../user_collections/friends_page.dart';
import '../src/help_page.dart';
import '../auth/log_in_page.dart';
import '../auth/logout_page.dart';
import 'package:capi_stonsker/auth/fire_auth.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  // get text for log in/ log out button
  String getText() {
    var user = FireAuth.auth.currentUser;
    if (user != null) {
      // user is logged in
      return "Log out";
    }
    // else, no user is logged in
    return "Log in";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: const Key('drawer'),
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                  backgroundColor: Colors.white,
                    radius: 45,
                )
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                      "The Capistonsker",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight + Alignment(0,0.45),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Novice ",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                                fontWeight: FontWeight.w900
                            )
                        ),
                        TextSpan(
                            text: "(7/4131)",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16
                            )
                        ),
                      ],
                    ),

                  ),
                )
              ],
            )
          ),
          ListTile(
            title: const Text('HOME'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.of(context).popUntil((route) => route.isFirst);
              //Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('MY MARKERS'),
            onTap: () {
              var user = FireAuth.auth.currentUser;
              if (user != null) {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyMarkersPage()
                    )
                );
              }
              else {
                //no user is signed in
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => noUserLoggedIn("My Markers")
                );
              }
            },
          ),
          ListTile(
            title: const Text('PLAN ROUTE'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlanRoutePage()
                  )
              );
            },
          ),
          ListTile(
            title: const Text('WISHLIST'),
            onTap: () {
              var user = FireAuth.auth.currentUser;
              if (user != null) {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WishListPage()
                    )
                );
              }
              else {
                //no user is signed in
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => noUserLoggedIn("Wishlist")
                );
              }
            },
          ),
          ListTile(
            title: const Text('FRIENDS'),
            onTap: () {
              var user = FireAuth.auth.currentUser;
              if (user != null) { //User is logged in
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FriendsPage()
                    )
                );
              }
              else {
                //no user is signed in
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => noUserLoggedIn("Friends")
                );
              }
            },
          ),
          ListTile(
            title: const Text('ACCOUNT'),
            onTap: () {
              var user = FireAuth.auth.currentUser;
              if(user != null){ //user is logged in
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountPage()
                    )
                );
              }
              else {
                //no user is signed in
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => noUserLoggedIn("Account")
                );
              }
            },
          ),
          ListTile(
            title: const Text('HELP'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HelpPage()
                  )
              );
            },
          ),
          FractionallySizedBox(
            widthFactor: 0.9, // means 100%, you can change this to 0.8 (80%)
            child: RaisedButton.icon(
              onPressed: () {
                var user = FireAuth.auth.currentUser;
                if(user != null){
                  // user is logged in
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => LogoutPage()
                      )
                  );
                }
                else {
                  //no user is signed in
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()
                      )
                  );
                }

              },
              color: Colors.blueGrey,
              label: Text(
                  getText(),
                  style: const TextStyle(color: Colors.white)
              ),
              icon: const Icon(Icons.account_circle, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog noUserLoggedIn(String page) {
    return AlertDialog(
      title: const Text('You are not logged in'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text("Please log in to continue to the " +  page + " page."),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          key: const Key('login'),
          child: const Text(
            'Log in',
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()
                )
            );
          },
        ),
        TextButton(
          child: const Text(
            'Dismiss',
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}