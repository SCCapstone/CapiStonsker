/*
  This file contains the method used to read a JSON with the marker information
  and upload the data to Firebase, assigning each Marker an ID.

  The program can be run by using: flutter run lib/markers/load_markers.dart
 */


import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/marker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final db = FirebaseFirestore.instance.collection('Markers');
int len = 0;
List<Marker> markers = [];


void main() async {
//Ensures Firebase connection initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await loadJsonLocal(); //TODO full list has "No Coordinates", #201
  markersToFirebase();
}

//Loads marker information from the JSON file, asynchronous because of file reading
loadJsonLocal() async {
  String data = await rootBundle.loadString('assets/locations_full.json'); //usc_markers folder for storage, assets folder for usage
  var markerObjsJson = jsonDecode(data)['Markers'] as List;
  markers = markerObjsJson.map((markerJson) => Marker.fromJsonLocal(markerJson))
      .toList();
  len = markers.length;
}

markersToFirebase() {
  //Sends all entries from the imported markers list to Firebase
  String county = "";
  int countyCount = 1;
  for (int count = 0; count < len; count++) {
    //Gets county name
    String parsed = markers[count].county.split(new RegExp('\\s+'))[0];
    //If the new parsed county name is different to the current, reset the count and use the new parsed name
    if (county != parsed) {
      county = parsed;
      countyCount = 1;
    }
    //Marker's ID based on county name and current count within that county
    String newID = parsed + countyCount.toString();
    countyCount++;

    //.doc.set is used to prevent duplicates: if doc of that name does not exist, one is created; if it does, it is updated
    db.doc(newID).set(<String, dynamic>{
      'name': markers[count].name,
      'rel_loc': markers[count].rel_loc,
      'desc': markers[count].desc,
      'gps': markers[count].gps,
      'county': markers[count].county,
      'id': newID
    });
  }
}