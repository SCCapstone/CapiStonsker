import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:capi_stonsker/nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up_page.dart';
import 'logout_page.dart';

final _auth = FirebaseAuth.instance;
class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
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
                child: Container(
                  width: 120,
                  height: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://picsum.photos/seed/264/600',
                  ),
                ),
              ),
              Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'UserName',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                        ),
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
                        'Novice',
                        style: TextStyle(
                          fontSize: 20
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
                        'This is a great User!',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'MY FAVORITES',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      subtitle: Text(
                        '2 saved',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF303030),
                        size: 20,
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                    ),
                    ListTile(
                      title: Text(
                        'PLACES TO VISIT',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      subtitle: Text(
                        '4 saved',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF303030),
                        size: 20,
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
                        '0 friends',
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF303030),
                        size: 20,
                      ),
                      tileColor: Color(0xFFF5F5F5),
                      dense: false,
                    )
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
