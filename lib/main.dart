/*
  Written by Joe Cammarata, James Davis, Matt Duggan, Lauren Hodges, and Ian Urton

  Test Application that is designed to illustrate the 3 tasks assigned as POC.
  - Receive the users current location in GPS coordinates
  - Sidebar Navigation
  - Bottom Menu
  - Achievements Page
 */

import 'package:capi_stonsker/Widgets/map_page.dart';
import 'package:flutter/material.dart';

import 'Widgets/bottom-nav-bar.dart';
import 'Widgets/marker_list_page.dart';

//Import firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

import '/Widgets/map_page.dart';
import '/Widgets/side_menu.dart';
import '/src/locations.dart' as locs;

void main() async {
  //Ensures Firebase connection initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await locs.getMarkers();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  //root of the application
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Container(
          width: MediaQuery.of(context).size.width*(2/3),
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(null), onPressed: () {  },
        ),
      ),

      body:Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: MapPage()),
        ],
      ),

      drawer: SideMenu(),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        // const Color.fromRGBO(40, 60, 80, 0.5),
        child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                tooltip: 'Open Menu',
                icon: const Icon(Icons.menu),
                iconSize: 40,
                onPressed: () => {
                _scaffoldKey.currentState!.openDrawer()},
              ),

              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height*.1,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              IconButton(
                tooltip: 'List View',
                icon: const Icon(Icons.list),
                iconSize: 40,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MarkerListPage()
                      )
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}