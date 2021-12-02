import 'package:capi_stonsker/Widgets/my_markers_page.dart';
import 'package:capi_stonsker/Widgets/plan_route_page.dart';
import 'package:capi_stonsker/Widgets/sign_up_page.dart';
import 'package:capi_stonsker/Widgets/wishlist_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'account_page.dart';
import 'friends_page.dart';
import 'help_page.dart';
import 'log_in_page.dart';
import 'logout_page.dart';

/* TODO pull user name, level, avatar, etc from Firebase to display at the top of the header.
 * Include default values for cases when a user is not logged in
 */

final _auth = FirebaseAuth.instance;
class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override

  // get text for log in/ log out button
  String getText() {
    var user = _auth.currentUser;
    if(user != null){
      // user is logged in
      return "Log out";
    }
    // else, no user is logged in
    return "Log in";
  }

  Widget build(BuildContext context) {
    return Drawer(
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
            },
          ),
          ListTile(
            title: const Text('FRIENDS'),
            onTap: () {
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
            },
          ),
          ListTile(
            title: const Text('ACCOUNT'),
            onTap: () {
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
                      builder: (context) => HelpPage()
                  )
              );
            },
          ),
          FractionallySizedBox(
            widthFactor: 0.9, // means 100%, you can change this to 0.8 (80%)
            child: RaisedButton.icon(
              onPressed: () {
                var user = _auth.currentUser;
                if(user != null){ //user is logged in
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => LogoutPage()
                      )
                  );
                }
                else {
                  //no user is signed in
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
                  style: TextStyle(color: Colors.white)
              ),
              icon: Icon(Icons.account_circle, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}