import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/Widgets/map_page.dart';
import '/Widgets/side_menu.dart';
import '/src/locations.dart' as locs;
import 'nav/bottom_nav_bar.dart';

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
          width: MediaQuery.of(context).size.width,
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
        automaticallyImplyLeading: false,
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
      bottomNavigationBar: BottomNavBarHome(scaffoldKey: _scaffoldKey,),
    );
  }
}