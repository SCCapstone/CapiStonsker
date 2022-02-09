/*
 * This class provides the functionality to pull markers from Firebase
 * and perform operations on them, which includes putting the markers
 * in list or map view, calculating distance, and searching by marker name
 *
 * This class should be imported using the suffix 'as locs'
 */

import 'dart:convert';
//Imports only items used for creating the ListView
import 'package:capi_stonsker/routing/navigation_page.dart';
import 'package:flutter/cupertino.dart' show BuildContext, Icon, ListView, Navigator, Text, Widget;
import 'package:flutter/material.dart' show IconButton, Icons, ListTile, MaterialPageRoute;
import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:capi_stonsker/markers/marker.dart';
import 'package:capi_stonsker/markers/full_info.dart';
import 'package:capi_stonsker/auth/fire_auth.dart';

// Instance definition of Markers collection
final db = FirebaseFirestore.instance.collection('Markers');
int len = 0;
List<Marker> markers = [];
List<Marker> visited = [];
List<Marker> wishlist = [];
List<Marker> nearby = [];
LatLng userPos = LatLng(0,0);
LatLng lastRecalc = LatLng(0,0);
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

// Get a user's wishlist
getWish() async {
  if (FireAuth.auth.currentUser != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FireAuth.auth.currentUser!.uid)
        .collection('wishlist')
        .get();
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      wishlist.add(Marker.fromJson(data));
    });
  }
}

//Stores user position
updatePos(LatLng pos) {
  //Only update userPos if pos is > 60ft (20m) difference (subject to change)
  if (distance(pos, userPos) >= 20) {
    userPos = pos;
    //Sort nearby list by userDist
    nearby.sort((a,b) { return a.userDist.compareTo(b.userDist); });
    //Check for nearby markers to add to visited
    nearby.forEach((element) {
      //Markers within 50m are marked as visited
      if (LengthUnit.Mile.to(LengthUnit.Meter, element.userDist) < 50) {
        //Add to visited list
        addToVisited(element);
      }
    });
    
    //
  }
  //Recalculate distances to construct the nearby list every change in 2km (adjust this)
  if (distance(pos, lastRecalc) >= 2000) { //Default initialization of 0,0 means this will run on first update
    lastRecalc = pos;
    calcDist();
  }
}

//How can we avoid calculating the full list?
calcDist({double lat = 0.0, double long = 0.0}) {
  //Allows current userPos to be overriden by passing coordinates in, passing none will use userPos
  //Added for functionality and unit testing
  //TODO in-place recalculation of the markers' distance causes issues with true unit testing
  LatLng pos;
  if (lat == 0.0 && long == 0.0) {
    pos = userPos;
  }
  else {
    pos = LatLng(lat,long);
  }
  //Recalculates distance to userPos for each element
  markers.forEach((element) {
    element.userDist = distance.as(LengthUnit.Mile,
        pos,
        LatLng(element.gps[0], -1.00 * element.gps[1]));
    //if userDist is less than 25 miles, add it to the nearby list
    if (element.userDist < 25) {
      nearby.add(element);
    }
  });
}

addToWish(Marker m) {
  //Eventually this will upload to Firebase using associated user auth id as the doc id
  //Then we'll have a StreamBuilder for those collections to listen and update a local list
  //For now, just update the local list

  //Check for duplicates (not necessary if buttons are designed correctly but just in case)
  if (!wishDupe(m)) {
    //Reference username to get collection name
    if (FireAuth.auth.currentUser != null) {
      //.doc.set is used to prevent duplicates: if doc of that name does not exist, one is created; if it does, it is updated
      //TODO CHECK FOLLOWING: Below needs update to reflect structure of username collections
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FireAuth.auth.currentUser!.uid)
          .collection('wishlist')
          .doc(m.name)
          .set(<String, dynamic>{
            'name': m.name,
            'rel_loc': m.rel_loc,
            'desc': m.desc,
            'gps': m.gps,
            'county': m.county,
      });

      wishlist.add(m);
    }
  }
}

removeWishFirebase(Marker m) {
  //Remove from Firebase
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FireAuth.auth.currentUser!.uid)
      .collection('wishlist')
      .doc(m.name)
      .delete();
  //Remove from local list
  wishlist.remove(m);
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
    //Reference username to get collection name
    if (FireAuth.auth.currentUser != null) {
      //.doc.set is used to prevent duplicates: if doc of that name does not exist, one is created; if it does, it is updated
      //TODO CHECK FOLLOWING: Below needs update to reflect structure of username collections
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FireAuth.auth.currentUser!.uid)
          .collection('visited')
          .doc(m.name)
          .set(<String, dynamic>{
        'name': m.name,
        'rel_loc': m.rel_loc,
        'desc': m.desc,
        'gps': m.gps,
        'county': m.county,
      });

      visited.add(m);
    }
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
    /*
      TODO may want to create a "sorted" list like wishlist/markers
      so the list does not need to be recreated, and small adjustments will not
      result in reordering the entire list
      Worst case of all items being resorted will only occur if user's
      coordinates jump a far distance (or during output testing)
     */
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
    trailing: IconButton(
      icon: const Icon(Icons.directions),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NavPage(
                  sentMarker: m,
                  distance: m.userDist,
                )
            )
        );
      },
    ),
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

// The following two methods return search results given a search string
Widget buildSearch(BuildContext context, searchString) {
  List<Marker> pass = List<Marker>.empty();
  calcDist();
  pass = markers.where((s) => s.name.toLowerCase().contains(searchString.toLowerCase())).toList();
  pass.sort((a,b) { return a.userDist.compareTo(b.userDist); });

  return ListView(
    children: pass.map((m) {
      return _buildSearch(context, m, m.userDist);
    }).toList(),
  );
}

Widget _buildSearch(BuildContext context, Marker m, double d) {
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