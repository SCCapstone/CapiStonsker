/*
  Test Application that is designed to illustrate the 3 tasks assigned as POC.
  - Receive the users current location in GPS coordinates
  - Sidebar Navigation
  - Bottom Menu
  - Achievements Page
 */

//Change to Main by Joe for Source Control Milestone.

import 'package:capi_stonsker/Widgets/map_page.dart';
import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'src/locations.dart' as locations;
import 'dart:async';

//Import firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '/Widgets/map_page.dart';
import '/Widgets/side_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  //root of the application
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Local Historical Markers'),
        backgroundColor: Colors.blueGrey,
      ),


      body: //Column(
      //children: <Widget> [
      //Container(

      //child:
      Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height-136,
              width: MediaQuery.of(context).size.width,
              child: MapPage()),
        ],
      ),

      drawer: SideMenu(),


      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
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
                  // TODO: Show the side menu,
                },
              ),

              Expanded(
                child: Container(
                  // TODO: Make Sizing of bottom bar and map not magic
                  height: 80,
                  width: 100,
                ),
              ),

              IconButton(
                tooltip: 'List View',
                icon: const Icon(Icons.list),
                iconSize: 40,
                onPressed: () {
                  // TODO: Go to List View State?
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}