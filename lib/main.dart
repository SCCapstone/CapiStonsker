//Change to Main by Joe for Source Control Milestone.

import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'src/locations.dart' as locations;
import 'dart:async';

//Import firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import 'Widgets/map_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width,
                  child: MapPage()),
              Row(
                children: [
                Column(
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: const Icon(Icons.navigation),
                    ),

                  ],
                ),
                Column(
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: const Icon(Icons.navigation),
                    ),

                  ],
               )
              ]
              )
            ],
          ),
        //),
        //new RaisedButton()
      //   //]
      // //),
      //   floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   child: const Icon(Icons.navigation),
      //   backgroundColor: Colors.green,
      //     heroTag: 1,
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   child: const Icon(Icons.navigation),
      //   backgroundColor: Colors.green,
      //   heroTag: 2,
      // ),
    );
  }
}