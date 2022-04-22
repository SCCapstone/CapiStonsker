
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  //This test simulates the calls made when adding/rejecting a friend with our Firebase structure
  test('Firestore Database Structure Test - Friends', () async {
    //Creates simulated Firestore for unit testing
    final instance = FakeFirebaseFirestore();
    //Populates simulated Firestore
    await instance.collection('Users').doc("uid1").set(<String, dynamic>{'email': 'uid1@mail.com'});
    await instance.collection('Users').doc("uid2").set(<String, dynamic>{'email': 'uid2@mail.com'});
    await instance.collection('Users').doc("uid3").set(<String, dynamic>{'email': 'uid3@mail.com'});

    CollectionReference uid1friends = instance.collection('Users').doc("uid1").collection('friends');
    CollectionReference uid2friends = instance.collection('Users').doc("uid2").collection('friends');
    QuerySnapshot snapshot;
    List<String> friends;

    //uid1 requests uid2 to be friends
    await uid1friends.doc('uid2@mail.com').set(<String, dynamic>{'from_me': true, 'has_accepted': false, 'uid': 'uid2'});
    await uid2friends.doc('uid1@mail.com').set(<String, dynamic>{'from_me': false, 'has_accepted': false, 'uid': 'uid1'});
    //uid2 accepts
    await uid1friends.doc('uid2@mail.com').update(<String, dynamic>{'has_accepted': true});
    await uid2friends.doc('uid1@mail.com').update(<String, dynamic>{'has_accepted': true});

    snapshot = await instance.collectionGroup('friends').where('has_accepted', isEqualTo: true).get();
    friends = [];
    snapshot.docs.forEach((doc) { friends.add(doc.id); });
    expect(friends.length, 2); //3 users, 2 are friends with 'has_accepted' fields = true


    //uid2 denies uid1's request
    uid2friends.doc('uid1@mail.com').delete();
    uid1friends.doc('uid2@mail.com').delete();

    snapshot = await instance.collectionGroup('friends').where('has_accepted', isEqualTo: true).get();
    friends = [];
    snapshot.docs.forEach((doc) { friends.add(doc.id); });
    expect(friends.length, 0); //3 users, none should have has_accepted = true

  });
}