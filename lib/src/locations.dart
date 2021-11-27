import 'dart:convert';
//Imports only items used for creating the ListView
import 'package:flutter/cupertino.dart' show Widget, ListView, Text, EdgeInsets;
import 'package:flutter/material.dart' show ListTile, Divider;
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'marker.dart';

//This class should be imported using the suffix 'as locs'

//Instance definition of Markers collection
final db = FirebaseFirestore.instance.collection('Markers');
int len = 0;
List<Marker> markers = [];
List<Marker> visited = [];
List<Marker> wishlist = [];

//Loads marker information from the JSON file, asynchronous because of file reading
loadJsonLocal() async {
  String data = await rootBundle.loadString('assets/locations.json');
  var markerObjsJson = jsonDecode(data)['Markers'] as List;
  markers = markerObjsJson.map((markerJson) => Marker.fromJson(markerJson))
      .toList();
  len = markers.length;
}

markersToFirebase() {
  //Sends all entries from the imported markers list to Firebase
  for (int count = 0; count < len; count++) {
    //.doc.set is used to prevent duplicates: if doc of that name does not exist, one is created; if it does, it is updated
    db.doc(markers[count].name).set(<String, dynamic>{
      'name': markers[count].name,
      'rel_loc': markers[count].rel_loc,
      'desc': markers[count].desc,
      'gps': markers[count].gps,
      'county': markers[count].county,
    });
  }
}

addToWish(Marker m) {
  //Eventually this will upload to Firebase using associated user auth id as the doc id
  //Then we'll have a StreamBuilder for those collections to listen and update a local list
  //For now, just update the local list

  //Check for duplicates (not necessary if buttons are designed correctly but just in case)
  if (!wishDupe(m)) {
    wishlist.add(m);
  }
}

bool wishDupe(Marker m) {
  for (Marker e in wishlist) {
    if (e == m) {
      return true;
    }
  } //Dupe is true if there is already that marker in the list
  return false;
}

addToVisited(Marker m) {
  //Eventually this will upload to Firebase using associated user auth id as the doc id
  //Then we'll have a StreamBuilder for those collections to listen and update a local list
  //For now, just update the local list

  //Check for duplicates (not necessary if buttons are designed correctly but just in case)
  bool dupe = false;
  for (Marker e in wishlist) {
    if (e == m) {
      dupe = true;
      break;
    }
  } //Dupe is true if there is already that marker in the list

  if (!dupe) {
    wishlist.add(m);
  }
}


getMarkers() async {
  QuerySnapshot snapshot = await db.get();
  snapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    markers.add(Marker.fromJson(data));
  });
}

//Build methods are moved into this class because of the assumption that these calls will be more commonly used
Widget buildMarkers() {
  return ListView.builder(
      itemCount: markers.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        return _buildRow(markers.elementAt(i));
      }
  );
}

//May be able to merge with above by passing a selection parameter
Widget buildWishList(BuildContext context) {
  //Add display for if list is empty?
  return ListView.builder(
      itemCount: wishlist.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        final index = i ~/ 2;
        return _buildRow(context, wishlist.elementAt(i));
      }
  );
}

/* This could end up being a better way to do above
  Widget _buildList() {
    return ListView(
      children: test.markers.map((m) {
        return _buildRow(m);
      }).toList(),
    );
  }
   */

//Creates ListTile widget from given Marker
Widget _buildRow(Marker m) {
  return ListTile(
      title: Text(m.name),
      subtitle: Text(m.county)
  );
}
