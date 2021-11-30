import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:capi_stonsker/nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sign_up_page.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Account Page"),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO add conditional logic here to go to login page if user not logged in or log out page if user is logged in
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => SignUp()
                  )
              );
            },
          )
        ],
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}
