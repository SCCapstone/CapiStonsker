import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';


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
        title: Text("Marker List Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: locs.buildMarkers(),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }


}
