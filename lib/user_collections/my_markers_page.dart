/*
 * This is a filler page that will eventually connect to firebase and display
 * the markers a user has visited
 *
 * TODO delete county_collection.dart once we add the actual functionality
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


    Marker m = user.markers[2];
    user.addToVisited(m);
    List<Marker> collection = user.visited;
    print(collection);

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
            children: const <Widget>[
            //   CountyCollection(countyName: 'ABBEVILLE',markerNum: 23,
            //     visited: [collection],),
            //   CountyCollection(countyName: 'ABBEVILLE',markerNum: 23),
            //   CountyCollection(countyName: "AIKEN", markerNum: 68),
            //   CountyCollection(countyName: "ALLENDALE", markerNum: 18),
            //   CountyCollection(countyName: 'ANDERSON',markerNum: 48),
            //   CountyCollection(countyName: "BAMBERG", markerNum: 18),
            //   CountyCollection(countyName: "BARNWELL", markerNum: 17),
            //   CountyCollection(countyName: 'BEAUFORT',markerNum: 67),
            //   CountyCollection(countyName: "BERKELEY", markerNum: 75),
            //   CountyCollection(countyName: "CALHOUN", markerNum: 23),
            //   CountyCollection(countyName: 'CHARLESTON',markerNum: 117),
            //   CountyCollection(countyName: "CHEROKEE", markerNum: 13),
            //   CountyCollection(countyName: "CHESTER", markerNum: 10),
            //   CountyCollection(countyName: 'CHESTERFIELD',markerNum: 23),
            //   CountyCollection(countyName: "CLAREDON", markerNum: 27),
            //   CountyCollection(countyName: "COLLETON", markerNum: 21),
            //   CountyCollection(countyName: 'DARLINGTON',markerNum: 85),
            //   CountyCollection(countyName: "DILLON", markerNum: 18),
            //   CountyCollection(countyName: "DORCHESTER", markerNum: 29),
            //   CountyCollection(countyName: 'EDGEFIELD',markerNum: 24),
            //   CountyCollection(countyName: "FAIRFIELD", markerNum: 24),
            //   CountyCollection(countyName: "FLORENCE", markerNum: 51),
            //   CountyCollection(countyName: 'GEORGETOWN',markerNum: 69),
            //   CountyCollection(countyName: "GREENVILLE", markerNum: 91),
            //   CountyCollection(countyName: "GREENWOOD", markerNum: 22),
            //   CountyCollection(countyName: 'HAMPTON',markerNum: 28),
            //   CountyCollection(countyName: "HORRY", markerNum: 31),
            //   CountyCollection(countyName: "JASPER", markerNum: 27),
            //   CountyCollection(countyName: 'KERSHAW',markerNum: 21),
            //   CountyCollection(countyName: "LANCASTER", markerNum: 34),
            //   CountyCollection(countyName: "LAURENS", markerNum: 21),
            //   CountyCollection(countyName: 'LEE',markerNum: 21),
            //   CountyCollection(countyName: "LEXINGTON", markerNum: 46),
            //   CountyCollection(countyName: "MARION", markerNum: 21),
            //   CountyCollection(countyName: 'MARLBORO',markerNum: 43),
            //   CountyCollection(countyName: "MCCORMICK", markerNum: 12),
            //   CountyCollection(countyName: "NEWBERRY", markerNum: 28),
            //   CountyCollection(countyName: 'OCONEE',markerNum: 23),
            //   CountyCollection(countyName: "ORANGEBURG", markerNum: 48),
            //   CountyCollection(countyName: "PICKENS", markerNum: 25),
            //   CountyCollection(countyName: 'RICHLAND',markerNum: 208),
            //   CountyCollection(countyName: "SALUDA", markerNum: 16),
            //   CountyCollection(countyName: "SPARTANBURG", markerNum: 37),
            //   CountyCollection(countyName: 'SUMTER',markerNum: 51),
            //   CountyCollection(countyName: "UNION", markerNum: 20),
            //   CountyCollection(countyName: "WILLIAMSBURG", markerNum: 26),
            //   CountyCollection(countyName: 'YORK',markerNum: 72),
            ],
          )
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}