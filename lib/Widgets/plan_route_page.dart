import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_bar.dart';
import 'side_menu.dart';

class PlanRoutePage extends StatelessWidget {
  PlanRoutePage({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Plan Route Page"),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
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
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}



