/*
 * This page displays a user's account information, pulled from Firebase.
 * Users will not be able to access this page unless they are logged in
 */

import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:capi_stonsker/auth/edit_account_page.dart';
import 'package:capi_stonsker/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:capi_stonsker/auth/fire_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../auth/take_picture_screen.dart';

class AccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountPageState();
  }
}

  class _AccountPageState extends State<AccountPage> {
    GlobalKey<_AccountPageState> key = GlobalKey();
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    final ImagePicker _picker = ImagePicker();

    @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    bool loggedin = user != null;
    String? image_url;
    if (loggedin) {
      image_url = FireAuth.auth.currentUser!.photoURL;
    }

    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop(context);
            }
        ),
        title: Text("Account Page"),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(

                        child: Ink.image(
                            image: (loggedin && image_url != null) ? Image.network(image_url).image : Image.asset('assets/image/icon.png').image,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover
                        )
                    ),
                  )
              ),
              Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child:
                      FutureBuilder(
                          future: FireAuth.getName(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return Text(
                                "${snapshot.data}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 25,
                                ),
                              );
                            }
                            else {
                              return CircularProgressIndicator();
                            }
                          }
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.7, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Text(
                          FireAuth.getBadge(),
                        style: TextStyle(
                            fontSize: 20,
                          color: Colors.black
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                      child: Text(
                        'My Bio',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 8),
                      child:
                      FutureBuilder(
                          future: FireAuth.getBio(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              String bio = "";
                              if (snapshot.hasData)
                                bio = "${snapshot.data}";
                              return Text(
                                bio,
                                style: TextStyle(
                                    fontSize: 20
                                ),
                              );
                            }
                            else {
                              return CircularProgressIndicator();
                            }
                          }
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'MY WISHLIST',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      subtitle: Text(
                        "${locs.wishlist.length.toString()} saved",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),

                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                    ),
                    ListTile(
                      title: Text(
                        'PLACES I\'VE VISITED',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      subtitle: Text(
                        "${locs.visited.length.toString()} saved",
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),

                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                    ),
                    ListTile(
                      title: Text(
                        'FRIENDS',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      subtitle: FutureBuilder(
                        future: getFriendNum(user!.uid),
                        builder: (context, AsyncSnapshot<int> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            return Text(
                              "${snapshot.data!} added",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            );
                          }
                          else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                    ),
                    SizedBox(height: 30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              child: Text("Edit Profile",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blueGrey)),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAccount()),
                                ).then((_) => setState(() {}));
                              })
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<int> getFriendNum(String uid) async {
      var snap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('friends')
          .get();
      return snap.size;
  }
}