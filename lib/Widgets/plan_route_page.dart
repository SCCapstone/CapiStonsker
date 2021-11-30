import 'package:capi_stonsker/nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}



