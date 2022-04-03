
/*
 * This page displays a user's account information, pulled from Firebase.
 * Users will not be able to access this page unless they are logged in
 */
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:capi_stonsker/auth/edit_account_page.dart';
import 'package:capi_stonsker/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:capi_stonsker/auth/fire_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../auth/take_picture_screen.dart';
import 'dart:math';


class AccountPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AccountPageState();
  }
}


  class _AccountPageState extends State<AccountPage> {

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
    GlobalKey<_AccountPageState> key = GlobalKey();
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    final ImagePicker _picker = ImagePicker();
    //String image_url = FireAuth.auth.currentUser!.photoURL!;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);
    bool loggedin = user != null;
    String? image_url;
    if (loggedin) {
      image_url = FireAuth.auth.currentUser!.photoURL;
    }

    //print(image_url);
    setState((){});
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
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                    height: 100,
                                    child: Column(children: <Widget>[
                                      ElevatedButton(
                                        child: const Text('Take Picture'),
                                        onPressed: () => {
                                          Navigator.pop(context),
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) => TakePictureScreen(camera:
                                                  cameras.first)
                                              )
                                          )
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey,
                                        ),
                                      ),
                                      ElevatedButton(
                                        child: const Text('Choose Photo from '
                                            'Library'),
                                        onPressed: () async {
                                          // Try to take the picture
                                          try {
                                            final gallery_image = await _picker
                                                .pickImage(source: ImageSource
                                                .gallery);

                                            // If the picture was chosen display
                                            if (gallery_image != null)
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => DisplayPictureScreen(
                                                    imagePath: gallery_image.path,
                                                  ),
                                                ),
                                              );
                                          } catch (e) {
                                            // If an error occurs, log the error to the console.
                                            print(e);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blueGrey,
                                        ),
                                      ),
                                    ])
                                );
                              }
                          );
                        },
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
                      padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                      child: Icon(
                        Icons.baby_changing_station,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ),

                  Align(
                    alignment: AlignmentDirectional(0.7, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: Text(
                          getBadge(),
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                      child: Text(
                        'About',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Text(
                        'Bio personalization will be implemented soon!',
                        style: TextStyle(
                            fontSize: 20
                        ),
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
                      subtitle: Text(
                        '0 friends', //TODO implement friends list
                        style: TextStyle(
                            fontSize: 20
                        ),
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
                                );
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
}