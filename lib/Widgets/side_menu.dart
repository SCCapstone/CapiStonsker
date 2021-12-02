import 'package:capi_stonsker/Widgets/my_markers_page.dart';
import 'package:capi_stonsker/Widgets/plan_route_page.dart';
import 'package:capi_stonsker/Widgets/wishlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'account_page.dart';
import 'friends_page.dart';
import 'help_page.dart';

/* TODO pull user name, level, avatar, etc from Firebase to display at the top of the header.
 * Include default values for cases when a user is not logged in
 */

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
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
                      settings: RouteSettings(name: "/account"),
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
        ],
      ),
    );
  }
}