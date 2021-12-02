import 'dart:convert';
//Imports only items used for creating the ListView
import 'package:flutter/cupertino.dart' show BuildContext, ListView, Navigator, Text, Widget;
import 'package:flutter/material.dart' show ListTile, MaterialPageRoute;
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:capi_stonsker/src/marker.dart';
import 'package:capi_stonsker/Widgets/full_info.dart';


// This class should be imported using the suffix 'as locs'

// Instance definition of Markers collection
final db = FirebaseFirestore.instance.collection('Markers');
int len = 0;
List<Marker> markers = [];
List<Marker> visited = [];
List<Marker> wishlist = [];
LatLng userPos = LatLng(0,0);
var distance = Distance();

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

getMarkers() async {
  QuerySnapshot snapshot = await db.get();
  snapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    markers.add(Marker.fromJson(data));
  });
}

updatePos(LatLng pos) {
  userPos = pos;
}

calcDist() {
  //Recalculates distance to userPos for each element
  markers.forEach((element) {
    element.userDist = LengthUnit.Meter.to(
      LengthUnit.Mile, distance(
        userPos,
        LatLng(element.gps[0], -1.00 * element.gps[1])
      )
    );
  });
}

addToWish(Marker m) {
  //Eventually this will upload to Firebase using associated user auth id as the doc id
  //Then we'll have a StreamBuilder for those collections to listen and update a local list
  //For now, just update the local list

  //Check for duplicates (not necessary if buttons are designed correctly but just in case)
  if (!wishDupe(m)) {
    //Reference username to get collection name

    //.doc.set is used to prevent duplicates: if doc of that name does not exist, one is created; if it does, it is updated
    //Below needs update to reflect structure of username collections
    /*
    FirebaseFirestore.instance.collection('Users').doc(username).collection('wishlist').set(<String, dynamic>{
      'name': m.name,
      'rel_loc': m.rel_loc,
      'desc': m.desc,
      'gps': m.gps,
      'county': m.county,
    });
    */
    
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

  if (!visitedDupe(m)) {
    visited.add(m);
  }
}

bool visitedDupe(Marker m) {
  for (Marker e in visited) {
    if (e == m) {
      return true;
    }
  } //Dupe is true if there is already that marker in the list
  return false;
}

Widget buildListDisplay(BuildContext context, int num) {
  List<Marker> pass = List<Marker>.empty();
  if (num == 0) { pass = markers; }
  else if (num == 1) { pass = wishlist; }
  else if (num == 2) { pass = visited; }
  else if (num == 3) {
    calcDist(); //Updates userDist for markers list
    //Duplicates markers list
    pass = List.from(markers);
    //Sorts new list by closest distance
    pass.sort((a,b) { return a.userDist.compareTo(b.userDist); });
  }

  return ListView(
    children: pass.map((m) {
      return _buildRow(context, m, m.userDist);
    }).toList(),
  );
}

//Creates ListTile widget from given Marker
Widget _buildRow(BuildContext context, Marker m, double d) {
  return ListTile(
      title: Text(m.name),
      //if userDist is default then display county instead of distance
      subtitle: d == 0.0 ? Text(m.county) : Text(d.toStringAsFixed(2) + " mi."),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullInfoPage(
                  sentMarker: m,
                )
            )
        );
      },
  );
}
