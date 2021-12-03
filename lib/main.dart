import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '/Widgets/map_page.dart';
import '/Widgets/side_menu.dart';
import '/src/locations.dart' as locs;
import 'Widgets/full_info.dart';
import 'Widgets/search_results.dart';
import 'nav/bottom_nav_bar.dart';
import '../src/marker.dart';

void main() async {
  //Ensures Firebase connection initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await locs.getMarkers();
  await locs.getWish();
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
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey menu_button = GlobalKey();
  GlobalKey marker_list = GlobalKey();
  GlobalKey search_bar = GlobalKey();

  @override
  void initState() {
    Future.delayed(Duration.zero, showTutorial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String search_val = "";
    //String searchKey;
    //Stream streamQuery;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5),
          ),
          //child: Center(
            //key: search_bar,
            child: FractionallySizedBox(
              //widthFactor: 0.9, // means 100%, you can change this to 0.8 (80%)
              child: RaisedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResultsPage()
                      )
                  );
                },
                color: Colors.white,
                label: Text(
                    "Search for a marker by name...",
                    style: TextStyle(color: Colors.grey)
                ),
                icon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
            // child: TextField(
            //   onChanged: (value) {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => SearchResultsPage()
            //         )
            //     );
            //   },
            //   decoration: InputDecoration(
            //     prefixIcon: Icon(Icons.search),
            //     suffixIcon: IconButton(
            //       icon: Icon(Icons.clear),
            //       onPressed: () {
            //         /* Clear the search field */
            //       },
            //     ),
            //     hintText: 'Search...',
            //     border: InputBorder.none,
            //   ),
            // ),
          //),
        ),
      ),

      body:Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: MapPage()
          ),
        ],
      ),

      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBarHome(
        scaffoldKey: _scaffoldKey,
        menu_button: menu_button,
        marker_list: marker_list,
      ),
    );
  }

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.brown,
      textSkip: "SKIP TUTORIAL",
      textStyleSkip: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip tutorial");
      },
    )..show();
  }

  void initTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "Target 1: Menu button",
        keyTarget: menu_button,
        alignSkip: Alignment.bottomCenter,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tap here from any page to access the menu.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30.0),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 2: List button",
        keyTarget: marker_list,
        alignSkip: Alignment.bottomCenter,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tap here for a list view of the markers. On other pages, tap here to return to the map.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 3: Search bar",
        keyTarget: search_bar,
        alignSkip: Alignment.bottomCenter,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height*0.5,
                      ),
                      child:Text(
                        "Use this search bar to find markers.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}