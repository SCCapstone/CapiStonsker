
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:capi_stonsker/markers/marker.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  //This test simulates the calls made to get a user's wishlist with our Firebase structure
  test('Firestore Database Structure Test - Marker ID', () async {
    //Creates simulated Firestore for unit testing
    final instance = FakeFirebaseFirestore();
    //Populates simulated Firestore
    await instance.collection('Markers').doc("COUNTY1").set(<String, dynamic>{ 'name': 'name1', 'desc': 'desc1', 'county': 'COUNTY', 'gps': [1,1], 'id': 'COUNTY1', 'rel_loc': 'rel_loc1' });
    await instance.collection('Markers').doc("COUNTY2").set(<String, dynamic>{ 'name': 'name2', 'desc': 'desc2', 'county': 'COUNTY', 'gps': [1,2], 'id': 'COUNTY2', 'rel_loc': 'rel_loc2' });
    await instance.collection('Markers').doc("COUNTY3").set(<String, dynamic>{ 'name': 'name3', 'desc': 'desc3', 'county': 'COUNTY', 'gps': [1,3], 'id': 'COUNTY3', 'rel_loc': 'rel_loc3' });
    await instance.collection('Markers').doc("COUNTY4").set(<String, dynamic>{ 'name': 'name4', 'desc': 'desc4', 'county': 'COUNTY', 'gps': [1,4], 'id': 'COUNTY4', 'rel_loc': 'rel_loc4' });
    await instance.collection('Users').doc("uid1").collection('wishlist').doc('COUNTY2').set(<String, dynamic>{'exists': true});
    await instance.collection('Users').doc("uid1").collection('wishlist').doc('COUNTY3').set(<String, dynamic>{'exists': true});
    await instance.collection('Users').doc("uid2").collection('wishlist').doc('COUNTY1').set(<String, dynamic>{'exists': true});
    await instance.collection('Users').doc("uid2").collection('wishlist').doc('COUNTY4').set(<String, dynamic>{'exists': true});

    QuerySnapshot snapshot;
    List<Marker> markers = [];
    List<Marker> wishlist = [];
    List<String> wishlistID = [];

    //getMarkers Test
    snapshot = await instance.collection('Markers').get();
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      markers.add(Marker.fromJson(data));
    });
    expect(markers.last.gps.last, 4); //Ensures that snapshot got all markers and that Marker.fromJson parsed correctly

    //getWishlist Test using Marker ID
    snapshot = await instance
        .collection('Users')
        .doc('uid1')
        .collection('wishlist')
        .get();
    snapshot.docs.forEach((doc) {
      wishlistID.add(doc.id);
    });
    //Match each ID to marker (only one match, no dupe IDs) and add marker to list
    wishlistID.forEach((id) {
      wishlist.add(
          markers.singleWhere(
                  (element) => element.id == id
          )
      );
    });
    expect(wishlist.last.gps.last, 3);

  });
}

