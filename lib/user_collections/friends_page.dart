/*
 * This page will display the current user's friends
 *
 * This page may also implement the ability to search for new friends
 *
 * As of the Proof of Concept, this page has not been implemented yet
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_nav/side_menu.dart';

class FriendsPage extends StatelessWidget {
  FriendsPage({Key? key}) : super(key: key);
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
        title: Text("Friends Page"),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}
