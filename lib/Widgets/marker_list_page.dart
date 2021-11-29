import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';


import '../main.dart';
import '../src/marker.dart';
import '../src/locations.dart' as locs;
import 'bottom_nav_bar.dart';

class MarkerListPage extends StatefulWidget {
  //const MarkerListPage({Key? key}) : super(key: key)
  MarkerListPage({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  State<MarkerListPage> createState() => _MarkerListPageState();
}

class _MarkerListPageState extends State<MarkerListPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Marker List Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: locs.buildMarkers(),
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

              IconButton(
                tooltip: 'List View',
                icon: const Icon(Icons.list),
                iconSize: 40,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage()
                      )
                  );
                },
              ),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }


}
