/*
 * This is a filler page that will eventually connect to firebase and display
 * the markers a user has visited
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:capi_stonsker/markers/marker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'county_collection.dart';
import '../app_nav/side_menu.dart';
import '../markers/locations.dart' as user;

class MyMarkersPage extends StatefulWidget {
  MyMarkersPage({Key? key}) : super(key: key);

  @override
  State<MyMarkersPage> createState() => _MyMarkersPageState();
}

class _MyMarkersPageState extends State<MyMarkersPage> {
  String text = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    List<Marker> collection = user.visited;

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
        title: Text("My Markers Page"),
        backgroundColor: Colors.blueGrey,
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: <Widget>[
              CountyCollection(countyName: 'ABBEVILLE',markerNum: 23,
                visited: collection),
              CountyCollection(countyName: 'ABBEVILLE',markerNum: 23,
                visited: collection),
              CountyCollection(countyName: "AIKEN", markerNum: 68, visited:
              collection),
              CountyCollection(countyName: "ALLENDALE", markerNum: 18,
                  visited: collection),
              CountyCollection(countyName: 'ANDERSON',markerNum: 48, visited:
              collection),
              CountyCollection(countyName: "BAMBERG", markerNum: 18, visited:
              collection),
              CountyCollection(countyName: "BARNWELL", markerNum: 17,
                  visited: collection),
              CountyCollection(countyName: 'BEAUFORT',markerNum: 67, visited:
              collection),
              CountyCollection(countyName: "BERKELEY", markerNum: 75,
                  visited: collection),
              CountyCollection(countyName: "CALHOUN", markerNum: 23, visited:
              collection),
              CountyCollection(countyName: 'CHARLESTON',markerNum: 117,
                  visited: collection),
              CountyCollection(countyName: "CHEROKEE", markerNum: 13,
                  visited: collection),
              CountyCollection(countyName: "CHESTER", markerNum: 10, visited:
              collection),
              CountyCollection(countyName: 'CHESTERFIELD',markerNum: 23,
                  visited: collection),
              CountyCollection(countyName: "CLAREDON", markerNum: 27,
                  visited: collection),
              CountyCollection(countyName: "COLLETON", markerNum: 21,
                  visited: collection),
              CountyCollection(countyName: 'DARLINGTON',markerNum: 85,
                  visited: collection),
              CountyCollection(countyName: "DILLON", markerNum: 18, visited:
              collection),
              CountyCollection(countyName: "DORCHESTER", markerNum: 29,
                  visited: collection),
              CountyCollection(countyName: 'EDGEFIELD',markerNum: 24,
                  visited: collection),
              CountyCollection(countyName: "FAIRFIELD", markerNum: 24,
                  visited: collection),
              CountyCollection(countyName: "FLORENCE", markerNum: 51,
                  visited: collection),
              CountyCollection(countyName: 'GEORGETOWN',markerNum: 69,
                  visited: collection),
              CountyCollection(countyName: "GREENVILLE", markerNum: 91,
                  visited: collection),
              CountyCollection(countyName: "GREENWOOD", markerNum: 22,
                  visited: collection),
              CountyCollection(countyName: 'HAMPTON',markerNum: 28, visited:
              collection),
              CountyCollection(countyName: "HORRY", markerNum: 31, visited:
              collection),
              CountyCollection(countyName: "JASPER", markerNum: 27, visited:
              collection),
              CountyCollection(countyName: 'KERSHAW',markerNum: 21, visited:
              collection),
              CountyCollection(countyName: "LANCASTER", markerNum: 34,
                  visited: collection),
              CountyCollection(countyName: "LAURENS", markerNum: 21, visited:
              collection),
              CountyCollection(countyName: 'LEE',markerNum: 21, visited:
              collection),
              CountyCollection(countyName: "LEXINGTON", markerNum: 46,
                  visited: collection),
              CountyCollection(countyName: "MARION", markerNum: 21, visited:
              collection),
              CountyCollection(countyName: 'MARLBORO',markerNum: 43, visited:
              collection),
              CountyCollection(countyName: "MCCORMICK", markerNum: 12,
                  visited: collection),
              CountyCollection(countyName: "NEWBERRY", markerNum: 28,
                  visited: collection),
              CountyCollection(countyName: 'OCONEE',markerNum: 23, visited:
              collection),
              CountyCollection(countyName: "ORANGEBURG", markerNum: 48,
                  visited: collection),
              CountyCollection(countyName: "PICKENS", markerNum: 25, visited:
              collection),
              CountyCollection(countyName: 'RICHLAND',markerNum: 208, visited:
              collection),
              CountyCollection(countyName: "SALUDA", markerNum: 16, visited:
              collection),
              CountyCollection(countyName: "SPARTANBURG", markerNum: 37,
                  visited: collection),
              CountyCollection(countyName: 'SUMTER',markerNum: 51, visited:
              collection),
              CountyCollection(countyName: "UNION", markerNum: 20, visited:
              collection),
              CountyCollection(countyName: "WILLIAMSBURG", markerNum: 26,
                  visited: collection),
              CountyCollection(countyName: 'YORK',markerNum: 72, visited:
              collection),
            ],
          )
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}