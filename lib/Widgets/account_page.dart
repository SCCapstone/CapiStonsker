import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:capi_stonsker/nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_up_page.dart';
import 'wishlist_page.dart';



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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {
              var user = _auth.currentUser;
              if(user != null){ //user is logged in
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => WishListPage()
                            //TODO in real life this would take you to a log out page.
                    )
                );
              }
              else {
                //no user is signed in
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => SignUp()
                    )
                );
              }

            },
          )
        ],
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}
