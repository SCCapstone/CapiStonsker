/*
 * This page is accessible from the home page and provides a list view
 * of the markers, sorted by distance from the user.
 *
 * A marker can be navigated to by pressing the nav button
 * to the right of the marker's name
 *
 * Tapping a marker opens that marker's full info page
 */

import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capi_stonsker/markers/marker.dart';
import 'package:capi_stonsker/markers/full_info.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendVisPage extends StatefulWidget {
  String fUID = "";
  FriendVisPage({Key? key, required this.fUID}) : super(key: key);

  @override
  State<FriendVisPage> createState() => _FriendVisPageState();
}

class _FriendVisPageState extends State<FriendVisPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String text = "";
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() {
                text = value;
              }
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    this.setState(() {
                      _controller.text = "";
                      text = "";
                    }
                    );
                  },
                ),
                hintText: 'Search for markers by name',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: FutureBuilder(
        future: friendFromFirebase(widget.fUID),
        builder: (context, AsyncSnapshot<List<Marker>> snapshot) {
          return buildListDisplay(context, snapshot, text);
        }
      ),

      //buildListDisplay(context, text),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }

  Future<List<Marker>> friendFromFirebase(String fID) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(fID)
        .collection('visited')
        .get();

    List<String> fVID = [];
    snapshot.docs.forEach((doc) {
      fVID.add(doc.id);
    });

    List<Marker> friendVis = [];
    //Match each ID to marker (only one match, no dupe IDs) and add marker to list
    fVID.forEach((id) {
      friendVis.add(
          locs.markers.singleWhere(
                  (element) => element.id == id
          )
      );
    });

    return friendVis;
  }

  Widget buildListDisplay(BuildContext context, AsyncSnapshot<List<Marker>> snapshot, String? searchString) {
    //TODO Firebase get for friendVis using fUID from param

    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      List<Marker> friendVis = snapshot.data!;
      if (friendVis.length == 0) {
        return Center(
            child: Text(
              "No Markers Visited",
              textAlign: TextAlign.center,
              textScaleFactor: 2,
            ),
        );
      }

      List<Marker> pass = friendVis;
      if (searchString != null && searchString != "") {
        pass = friendVis.where((s) => s.name.toLowerCase().contains(searchString.toLowerCase())).toList();
      }

      return ListView(
        children: pass.map((m) {
          return _buildRow(context, m);
        }).toList(),
      );
    }
    else {
      return CircularProgressIndicator();
    }
  }

  //Creates ListTile widget from given Marker
  Widget _buildRow(BuildContext context, Marker m) {
    return ListTile(
      title: Text(m.name),
      //if userDist is default then display county instead of distance
      subtitle: Text(m.county),
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
}
