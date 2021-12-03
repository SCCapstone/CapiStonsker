/*
 * The idea of this page is to plan complex routes, such as routes that
 * visit multiple different markers
 *
 * This page is not yet implemented as of the Proof of Concept release
 *
 * Consider: we may end up removing this page and not implementing this feature
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/app_nav/side_menu.dart';

class PlanRoutePage extends StatelessWidget {
  PlanRoutePage({Key? key}) : super(key: key);
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
        title: Text("Plan Route Page"),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}



