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
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/auth/fire_auth.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>  {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              //TODO Open dialog box to add friend by email
            }
          )
        ],
        title: Text("Friends Page"),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
      //body: ,
    );
  }

  Widget buildListDisplay(BuildContext context) {
    return ListView(
      children: pass.map((m) {
        return _buildRow(context, m, m.userDist);
      }).toList(),
    );
  }

//Creates ListTile widget from given Marker
  Widget _buildRow(BuildContext context, bool pending, bool from_me) {
    return ListTile(
      title: Text(m.name),
      //if userDist is default then display county instead of distance
      subtitle: d == 0.0 ? Text(m.county) : Text(d.toStringAsFixed(2) + " mi."),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullInfoPage(
                  sentMarker: m,
                )
            )
        );
      },
    );
  }
}

class Friend {
  final String email;
  bool from_me;
  bool has_accepted;

  //Constructor
  Marker(this.email, this.from_me, this.has_accepted);

}