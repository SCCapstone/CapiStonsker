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
import 'package:capi_stonsker/user_collections/friends_vis.dart';
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
    List<Friend> pending = [];
    List<Friend> friends = [];

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
              if (f.has_accepted == false) {
                if (!pending.contains(f))
                  pending.add(f);
              }
              else {
                if(!friends.contains(f))
                  friends.add(f);
              }
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
    return (f.has_accepted ? friendCard(f) : pendingCard(f));
  }

  Card pendingCard(Friend f) {
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

    return Card(child: ListTile(
      title: Text(f.email),
      subtitle: (f.from_me) ? Text("Response pending...") : null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: (f.from_me) ? Icon(Icons.check_circle) : Icon(Icons.check_circle_outline),
            color: Colors.blue,
            onPressed: (){
              if (!f.from_me) {
                forThis.update(<String, dynamic>{
                  'has_accepted': true,
                });
                forOther.update(<String, dynamic>{
                  'has_accepted': true,
                });
                setState(() { });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.cancel_outlined),
            color: Colors.red,
            onPressed: (){
              //Deletes for this user
              forThis.delete();
              //Deletes for other user
              forOther.delete();
              setState(() { });
            },
          ),
        ],
      )
    ));
  }

  Card friendCard(Friend f) {
    return Card(child: ListTile(
      title: Text(f.email),
      subtitle: FutureBuilder(
        future: getFriendVis(f.uid),
        builder: (context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return Text("${snapshot.data} markers visited!");
          }
          else {
            return CircularProgressIndicator();
          }
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FriendVisPage(fUID: f.uid)
              )
          );
        },
      ),
    ));
  }

  Future<int> getFriendVis(String fUID) async {
    var snap = await FirebaseFirestore.instance
        .collection('Users')
        .doc(fUID)
        .collection('visited')
        .get();
    return snap.size;
  }

  AlertDialog addFriend() {
    User? user = Provider.of<User?>(context);
    bool logged_in = user != null;
    final _emailAdd = GlobalKey<FormState>();

    String email = "";
    return AlertDialog(
      title: const Text('Add a Friend by Email'),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: TextFormField(
                key: _emailAdd,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
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
            QuerySnapshot userDupe = await FirebaseFirestore.instance
                .collection('Users')
                .where("email", isEqualTo: email)
                .get();
            QuerySnapshot friendDupeSnap = await FirebaseFirestore.instance
                .collection('Users')
                .doc(FireAuth.auth.currentUser!.uid)
                .collection('friends')
                .get();
            //No duplicate emails, so as long as one user with it exists then it is that user
            List<Friend> friendDupeList = friendDupeSnap.docs.map((doc) =>
                Friend.fromFirestore(doc)).toList();

            String error = "";
            bool userValid = false;
            if (email.isEmpty) {
              error = "Please enter an email.";
            }
            else if (logged_in && email == user.email) {
              error = "You cannot add yourself as a friend.";
            }
            else if (!(userDupe.docs.length == 1)) {
              error = "This email is not associated with an account.";
            }
            else if (friendDupeList.any((element) => element.email == email)) {
              error =
              "This user is already on your Friends list, or a response is pending.";
            }
            else {
              userValid = true;
            }

            //If email is contained, call setState
            if (userValid) {
              if (logged_in) {
                setState(() {
                  String uid = userDupe.docs[0].id; //uid of that email
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
                  Navigator.of(context).pop();
                });
              }
            }
            else {
              setState(() {
                showDialog(context: context, builder: (context) {
                  return new SimpleDialog(
                      children: <Widget>[
                        new Center(child: new Container(child: new Text(
                            'Invalid. ' + error)))
                      ]);
                });
              });
            }
          }
        ),
      ],
    );
  }
}