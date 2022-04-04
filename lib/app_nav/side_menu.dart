/*
 * The side menu, accessible at all times from the menu button at the
 * left of the bottom menu bar, allows a user to navigate throughout the app
 *
 * TODO pull user name, level, avatar, etc from Firebase to display at the top of the header.
 */


import 'package:auto_size_text/auto_size_text.dart';
import 'package:capi_stonsker/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/auth/account_page.dart';
import 'package:capi_stonsker/auth/log_in_page.dart';
import 'package:capi_stonsker/auth/logout_page.dart';
import 'package:capi_stonsker/auth/fire_auth.dart';
import 'package:capi_stonsker/src/help_page.dart';
import 'package:capi_stonsker/user_collections/my_markers_page.dart';
import 'package:capi_stonsker/user_collections/friends_page.dart';
import 'package:provider/provider.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);


  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  String getBadge() {
    int amount = locs.visited.length.toInt();
    String badge="";
    if(amount>=0&&amount<=414){
      badge="Novice";
    }
    if(amount>=415&&amount<=1034){
      badge="Intermediate";
    }
    if(amount>=1035&&amount<=2064){
      badge="Advanced";
    }
    if(amount>=2065&&amount<=3094){
      badge="Expert";
    }
    if(amount>=3095&&amount<=4130){
      badge="Legend";
    }
    if(amount==4131){
      badge="Capistonktastic";
    }
    return badge;
  }
  // get text for log in/ log out button
  String getText() {
    if (FireAuth.auth.currentUser != null) {
      // user is logged in
      return "Log out";
    }
    // else, no user is logged in
    return "Log in";
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    bool loggedin = user != null;
    String? image_url;
    if (loggedin) {
      image_url = FireAuth.auth.currentUser!.photoURL;
    }

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
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          foregroundImage: (loggedin && image_url != null) ? Image.network(image_url).image : Image.asset('assets/image/icon.png').image,
                          backgroundColor: Colors.white,
                          radius: 50,
                        ),
                      ),
                  ),

                  Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                        child: (!loggedin) ? Text(
                          "Welcome!",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 25,
                          ),
                        ) : Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 75,
                            child: AutoSizeText(
                              user.email!,
                              maxLines: 3,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  Align(
                      alignment: Alignment.centerRight + Alignment(0,0.45),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: getBadge(),
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900
                                  )
                              ),
                              TextSpan(
                                //TODO update according to user
                                  text: "(${locs.visited.length.toString()}/4131)",
                                  style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 16
                                  )
                              ),
                            ],
                          ),

                        ),


                      ))
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
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyHomePage(show: false, popup: true, points: path, duration: dur, distance: dist,)
              ));
              //Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('MY MARKERS'),
            onTap: () {
              if (loggedin) {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyHomePage(show: false, popup: true, points: path, duration: dur, distance: dist,)
                ));
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
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyHomePage(show: false, popup: true, points: path, duration: dur, distance: dist,)
              ));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(show: false, popup: false, points: path, duration: dur, distance: dist,)
                  )
              );
            },
          ),
          ListTile(
            title: const Text('FRIENDS'),
            onTap: () {
              if (loggedin) { //User is logged in
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyHomePage(show: false, popup: true, points: path, duration: dur, distance: dist,)
                ));
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
              if(loggedin){ //user is logged in
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyHomePage(show: false, popup: true, points: path, duration: dur, distance: dist,)
                ));
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
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyHomePage(show: false, popup: true, points: path, duration: dur, distance: dist,)
              ));
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
                if(loggedin){
                  // user is logged in
                  Navigator.pop(context);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MyHomePage(show: false, popup: true, points: path, duration: dur, distance: dist,)
                  ));
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => LogoutPage()
                      )
                  );
                }
                else {
                  //no user is signed in
                  Navigator.pop(context);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MyHomePage(show: false, popup: true, points: path, duration: dur, distance: dist,)
                  ));
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










