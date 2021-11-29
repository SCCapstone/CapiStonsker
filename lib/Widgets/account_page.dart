import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'log_in_page.dart';

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
                    builder: (context) => LogIn()
                  )
              );
            },
          )
        ],
      ),
      body: Center(
        child: ElevatedButton(
          //color: Colors.blueGrey,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Go back home"),
        ),
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        // const Color.fromRGBO(40, 60, 80, 0.5),
        child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                tooltip: 'Open Menu',
                icon: const Icon(Icons.menu),
                iconSize: 40,
                onPressed: () => {
                  _scaffoldKey.currentState!.openDrawer()},
              ),

              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height*.1,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
