/*
 * This page will display the current user's friends
 *
 * This page may also implement the ability to search for new friends
 *
 * As of the Proof of Concept, this page has not been implemented yet
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:capi_stonsker/auth/fire_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/user_collections/friend.dart';
import 'package:provider/provider.dart';

class FriendsPage extends StatefulWidget {
  FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>  {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    //Gets stream of friends list
    //var all_friends = Provider.of<List<Friend>?>(context);
    List<Friend> pending = [];
    List<Friend> friends = [];
    //Filter friend list into pending and friends
    /*
    if (all_friends != null) {
      all_friends.forEach((f) {
        if (f.has_accepted == false)
          pending.add(f);
        else
          friends.add(f);
      });
    }
     */

    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: () {
              //Open dialog box
              showDialog(
                context: context,
                builder: (BuildContext context) => addFriend(),
              );
            }
          )
        ],
        title: Text("Friends Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(Provider.of<User?>(context)!.uid)//FireAuth.auth.currentUser?.uid)
            .collection('friends')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
            var allfriends = snapshot.data!.docs.map((doc) => Friend.fromFirestore(doc)).toList();
            allfriends.forEach((f) {
              if (f.has_accepted == false)
                pending.add(f);
              else
                friends.add(f);
            });
            return buildListDisplay(context, pending, friends);
        },
      ),
      // buildListDisplay(context, pending, friends),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
      //body: ,
    );

  }

  //List Builder
  Widget buildListDisplay(BuildContext context, List<Friend> pending, List<Friend> friends) {

    pending.sort((a,b) => a.pendingSort(b));
    List<Widget> pendingList = pending.map(
            (f) {
          return _buildRow(context, f); }
    ).toList();

    friends.sort();
    List<Widget> friendsList = friends.map(
            (f) {
          return _buildRow(context, f); }
    ).toList();

    return ListView(
      children: pendingList + friendsList,
    );
  }

//Creates ListTile widget from given Friend
  Widget _buildRow(BuildContext context, Friend f) {
    DocumentReference forThis = FirebaseFirestore.instance
        .collection('Users')
        .doc(FireAuth.auth.currentUser!.uid)
        .collection('friends')
        .doc(f.email);
    DocumentReference forOther = FirebaseFirestore.instance
        .collection('Users')
        .doc(f.uid)
        .collection('friends')
        .doc(FireAuth.auth.currentUser!.email);

    Widget subTitle;
    if (f.has_accepted == false) {
      if (f.from_me == true) {
        subTitle = Text("Response pending...");
      }
      else { //f.from_me == false
        subTitle = ButtonBar(
          children: [
            OutlinedButton(
              child: Text("Accept"),
              style: OutlinedButton.styleFrom(primary: Colors.blue),
              onPressed: (){
                //TODO Firebase edits
                forThis.update(<String, dynamic>{
                  'has_accepted': true,
                });
                forOther.update(<String, dynamic>{
                  'has_accepted': true,
                });
              },
            ),
            OutlinedButton(
              child: Text("Deny"),
              style: OutlinedButton.styleFrom(primary: Colors.red),
              onPressed: (){
                //Deletes for this user
                forThis.delete();
                //Deletes for other user
                forOther.delete();
              },
            ),
          ],
        );
      }
    }
    else { //TODO what to show here
      subTitle = Text("Yay friends!");
    }

    return Card(child: ListTile(
      title: Text(f.email),
      subtitle: subTitle,
    ));
  }

  AlertDialog addFriend() {
    User? user = Provider.of<User?>(context);
    bool logged_in = user != null;

    String email = "";
    return AlertDialog(
      title: const Text('Add a Friend by Email'),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter an Email.";
                  }
                  if (logged_in && value == user.email) {
                    return "You cannot add yourself as a friend.";
                  }
                },
                textAlign: TextAlign.center,
              ),
            );
          }
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          onPressed: () async {
            //Query Firebase for user with that email
            QuerySnapshot snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .where("email", isEqualTo: email)
                .get();
            bool userExists = snapshot.docs.length == 1; //No duplicate emails, so as long as one exists

            setState(() {
              //If email is contained, call setState
              if (userExists) {
                if (logged_in) {
                  String uid = snapshot.docs[0].id; //uid of that email
                  //Add R to S's friend list
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FireAuth.auth.currentUser!.uid)
                      .collection('friends')
                      .doc(email)
                      .set(<String, dynamic>{
                        'from_me': true,
                        'has_accepted': false,
                        'uid': uid,
                      });
                  //Add S to R's friend list
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(uid)
                      .collection('friends')
                      .doc(user.email)
                      .set(<String, dynamic>{
                    'from_me': false,
                    'has_accepted': false,
                    'uid': FireAuth.auth.currentUser!.uid,
                  });
                }
                Navigator.of(context).pop();
              }
              else {
                showDialog(context: context, builder: (context) {
                  return new SimpleDialog(
                      children: <Widget>[
                        new Center(child: new Container(child: new Text('Not a valid user.')))
                      ]);
                });
              }
            });
          },
        ),
      ],
    );
  }
}