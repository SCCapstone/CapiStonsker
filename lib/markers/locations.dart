/*
 * This class provides the functionality to pull markers from Firebase
 * and perform operations on them, which includes putting the markers
 * in list or map view, calculating distance, and searching by marker name
 *
 * This class should be imported using the suffix 'as locs'
 */

//Imports only items used for creating the ListView
import 'package:capi_stonsker/routing/navigation_page.dart';
import 'package:flutter/cupertino.dart' show BuildContext, Icon, ListView, Navigator, Text, Widget;
import 'package:flutter/material.dart' show IconButton, Icons, ListTile, MaterialPageRoute;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:latlong2/latlong.dart';
import 'package:capi_stonsker/markers/marker.dart';
import 'package:capi_stonsker/markers/full_info.dart';
import 'package:capi_stonsker/auth/fire_auth.dart';

// Instance definition of Markers collection
int len = 0;
List<Marker> markers = [];
List<Marker> visited = [];
List<String> visitedID = [];
List<Marker> wishlist = [];
List<String> wishlistID = [];
List<Marker> nearby = [];
List<Marker> searchRes = [];

final List<String> fullCounties = ["ABBEVILLE","AIKEN","ALLENDALE","ANDERSON","BAMBERG","BARNWELL","BEAUFORT","BERKELEY","CALHOUN","CHARLESTON","CHEROKEE","CHESTER","CHESTERFIELD","CLARENDON",
  "COLLETON","DARLINGTON","DILLON","DORCHESTER","EDGEFIELD","FAIRFIELD","FLORENCE","GEORGETOWN","GREENVILLE","GREENWOOD","HAMPTON","HORRY","JASPER","KERSHAW","LANCASTER","LAURENS","LEE",
  "LEXINGTON","MARION","MARLBORO","MCCORMICK","NEWBERRY","OCONEE","ORANGEBURG","PICKENS","RICHLAND","SALUDA","SPARTANBURG","SUMTER","UNION","WILLIAMSBURG","YORK"];

LatLng userPos = LatLng(0,0);
LatLng lastRecalc = LatLng(0,0);
var distance = Distance(roundResult: false);


getSearchResults(String SearchText) {
  searchRes = markers.where((s) => s.name.toLowerCase().contains(SearchText.toLowerCase())).toList();
}


//Stores user position
updatePos(LatLng pos) {
  //Only update userPos if pos is > 60ft (20m) difference (subject to change)
  if (distance(pos, userPos) >= 20) {
    userPos = pos;

    //Check for nearby markers to add to visited
    nearby.forEach((element) {
      //Calculate updated userDist (only for Markers in nearby - minimizes unnecessary calculations)
      element.userDist = distance.as(LengthUnit.Mile,
          userPos,
          LatLng(element.gps[0], -1.00 * element.gps[1]));
      //Markers within 50m are marked as visited
      if (LengthUnit.Mile.to(LengthUnit.Meter, element.userDist) < 50) {
        //Add to visited list
        addToVisited(element);
      }
    });
    //Sort nearby list by userDist
    nearby.sort((a,b) { return a.userDist.compareTo(b.userDist); });

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
  }
  );
  nearby.sort((a, b) => a.userDist.compareTo(b.userDist));
}

getMarkers() async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Markers').get();
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
      wishlistID.add(doc.id);
      //Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      //wishlist.add(Marker.fromJson(data));
    });

    //Match each ID to marker (only one match, no dupe IDs) and add marker to list
    wishlistID.forEach((id) {
      wishlist.add(
          markers.singleWhere(
                  (element) => element.id == id
          )
      );
    });
  }
}

// Get a user's visited
getVis() async {
  if (FireAuth.auth.currentUser != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FireAuth.auth.currentUser!.uid)
        .collection('visited')
        .get();
    snapshot.docs.forEach((doc) {
      visitedID.add(doc.id);
      //Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      //visited.add(Marker.fromJson(data));
    });

    //Match each ID to marker (only one match, no dupe IDs) and add marker to list
    visitedID.forEach((id) {
      visited.add(
          markers.singleWhere(
                  (element) => element.id == id
          )
      );
    });
  }
}

addToWish(Marker m) {
  //Check for duplicates (not necessary if buttons are designed correctly but just in case)
  if (!wishDupe(m)) {
    //Reference username to get collection name
    if (FireAuth.auth.currentUser != null) {
      //.doc.set is used to prevent duplicates: if doc of that name does not exist, one is created; if it does, it is updated
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FireAuth.auth.currentUser!.uid)
          .collection('wishlist')
          .doc(m.id)
          .set(<String, dynamic>{'exists': true}); //.set must be used to create the new doc with an assigned name
      /*
          .doc(m.name)
          .set(<String, dynamic>{
            'name': m.name,
            'rel_loc': m.rel_loc,
            'desc': m.desc,
            'gps': m.gps,
            'county': m.county,
      });
      */

      wishlist.add(m);
      wishlistID.add(m.id);
    }
  }
}

removeWishFirebase(Marker m) {
  //Remove from Firebase
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FireAuth.auth.currentUser!.uid)
      .collection('wishlist')
      .doc(m.id)
      .delete();
  //Remove from local list
  wishlist.remove(m);
  //Removes ID
  wishlistID.remove(m.id);
}

bool wishDupe(Marker m) {
  //Dupe is true is the marker ID is already in list
  for (String e in wishlistID)
    if (m.id == e)
      return true;

  return false;

  /*
  for (Marker e in wishlist) {
    if (e == m) {
      return true;
    }
  } //Dupe is true if there is already that marker in the list
  return false;
   */
}

addToVisited(Marker m) {
  if (!visitedDupe(m)) {
    //Reference username to get collection name
    if (FireAuth.auth.currentUser != null) {
      //.doc.set is used to prevent duplicates: if doc of that name does not exist, one is created; if it does, it is updated
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FireAuth.auth.currentUser!.uid)
          .collection('visited')
          .doc(m.id)
          .set(<String, dynamic>{'exists': true}); //.set must be used to create the new doc with an assigned name
      /*
          .doc(m.name)
          .set(<String, dynamic>{
            'name': m.name,
            'rel_loc': m.rel_loc,
            'desc': m.desc,
            'gps': m.gps,
            'county': m.county,
      });
      */

      visited.add(m);
      visitedID.add(m.id);
    }
  }
}

//Likely not used but added for functionality in case
removeVisFirebase(Marker m) {
  //Remove from Firebase
  FirebaseFirestore.instance
      .collection('Users')
      .doc(FireAuth.auth.currentUser!.uid)
      .collection('visited')
      .doc(m.id)
      .delete();
  //Remove from local list
  visited.remove(m);
  //Removes ID
  visitedID.remove(m.id);
}

bool visitedDupe(Marker m) {
  //Dupe is true is the marker ID is already in list
  for (String e in visitedID)
    if (m.id == e)
      return true;

  return false;

  /*
  for (Marker e in visited) {
    if (e == m) {
      return true;
    }
  } //Dupe is true if there is already that marker in the list
  return false;
  */
}

Widget buildListDisplay(BuildContext context, int num, String? searchString, {List<String>? counties}) {
  List<Marker> pass = [];
  if (num == 0) { pass = markers; } //Full list
  else if (num == 1) { pass = wishlist; } //Wishlist
  else if (num == 2) { pass = visited; } //Visited
  else if (num == 3) { //Full list sorted nearby
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
  else if (num == 4) { //County
    markers.forEach((m) {
      if (counties!.contains(m.county.split(new RegExp('\\s+'))[0]))
        pass.add(m);
    });
    pass.sort((a,b) => a.name.compareTo(b.name));
  }

  if (searchString != null && searchString != "") {
    pass = markers.where((s) => s.name.toLowerCase().contains(searchString.toLowerCase())).toList();
  }

  return ListView(
    children: pass.map((m) {
      return _buildRow(context, m, m.userDist);
    }).toList(),
  );
}

MapBoxNavigation _directions = new MapBoxNavigation();

bool _isMultipleStop = false;
double _distanceRemaining =0.0, _durationRemaining = 0.0;
late MapBoxNavigationViewController _controller;
bool _routeBuilt = false;
bool _isNavigating = false;

//Creates ListTile widget from given Marker
Widget _buildRow(BuildContext context, Marker m, double d) {
  return ListTile(
    trailing: IconButton(
      icon: const Icon(Icons.directions),
      onPressed: () async {
        var wayPoints = <WayPoint>[];
        wayPoints.add(WayPoint(name: "origin", latitude:  userPos.latitude, longitude:  userPos.longitude));
        wayPoints.add(WayPoint(name: "marker", latitude: m.gps.first, longitude:  -m.gps.last));

        await _directions.startNavigation(
            wayPoints: wayPoints,
            options: MapBoxOptions(
                initialLatitude: userPos.latitude,
                initialLongitude: userPos.longitude,
                animateBuildRoute: false,
                zoom: 10.0,
                mode: MapBoxNavigationMode.walking,
                simulateRoute: false,
                language: "en",
                units: VoiceUnits.imperial)
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