/*
 * This app was written by Matt Duggan, Joe Cammarata, James Davis,
 * Lauren Hodges, and Ian Urton
 *
 * We are currently in the Beta Release stage of app development
 *
 * This page is the one that opens on startup and contains a search bar,
 * map that displays historical markers, a tutorial for new users, and a
 * bottom navigation bar with links to a side menu and a list view of the markers
 */


import 'package:camera/camera.dart';
import 'package:capi_stonsker/ui/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:capi_stonsker/src/map_page.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/user_collections/friend.dart';
import 'package:capi_stonsker/auth/fire_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong2/latlong.dart' as ll;

SharedPreferences sharedPreferences = SharedPreferences.getInstance() as SharedPreferences;

// Global for access across pages
List<CameraDescription> cameras = [];

Future<void> main() async{



  //Ensures Firebase connection initialized
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  // Access camera for User Pictures
  cameras = await availableCameras();

  runApp(MyApp(key: Key("App")));
}

class MyApp extends StatelessWidget {

  const MyApp({required Key key}) : super(key: key);

  //root of the application
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // Make user stream available
          StreamProvider<User?>.value(value: FirebaseAuth.instance.idTokenChanges(), initialData: null),

          // Make total friends stream available
          /*
          StreamProvider<List<Friend>>.value(
            value: FirebaseFirestore.instance
                .collection('Users')
                .doc(FireAuth.auth.currentUser?.uid)
                .collection('friends')
                .snapshots()
                .map((snap) =>
                snap.docs.map((doc) => Friend.fromFirestore(doc)).toList()),
            initialData: [],
          ),
          */
        ],

        // All data will be available in this child and descendants
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new Splash(),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  bool show;
  MyHomePage({Key? key, required this.show}) : super(key: key);

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

  MapController mapController = MapController();

  String searchText = "";
  final TextEditingController _controller = new TextEditingController();

  List<String> items = <String>["None","County","Visited","Wishlist"];
  String? selectedDrop;
  List<bool> isSelected = List.filled(46, false);
  List<String> selectedCounties = [];
  int selectedList = 3;



  @override
  void initState() {
    if(widget.show == true) {
      Future.delayed(Duration.zero, showTutorial);
    }
    MapController mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //String search_val = "";
    //String searchKey;
    //Stream streamQuery;
    return Scaffold(
      extendBody: true, //TODO change position of move to current loc button
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() {
                searchText = value;
                selectedList = 5;
              }
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    this.setState(() {
                      _controller.text = "";
                      searchText = "";
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
        actions: <Widget>[
          DropdownButtonHideUnderline(
              child: DropdownButton(
                iconSize: 30,
                value: selectedDrop,
                hint: Icon(Icons.filter_list),
                items: items.map<DropdownMenuItem<String>>((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return items.map<Widget>((String item) {
                    switch (item) {
                      case "County": { return Icon(Icons.map_outlined); }
                      case "Visited": { return Icon(Icons.location_on); }
                      case "Wishlist": { return Icon(Icons.star); }
                      default: { return Icon(Icons.filter_list); }
                    }
                  }).toList();
                },
                onChanged: (String? value) => setState(() {
                  selectedDrop = value!;
                  switch (value) {
                    case "County": {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => countySelect(),
                      );
                    } break;
                    case "Visited": {
                      selectedList = 2;

                    } break;
                    case "Wishlist": { selectedList = 1; } break;
                    default: { selectedList = 3; }
                  }


                }),
              )
          )
        ],
      ),

      body:Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: MapPage(
                 key: ValueKey<int>(selectedList),
                 list: selectedList,
                 counties: selectedCounties,
                 searchText: searchText,
                 controller: mapController)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 25,
                child: IconButton(
                  //key: widget.menu_button,
                  //tooltip: 'Open Menu',
                    icon: Icon(Icons.my_location),
                    color: Colors.white,
                    iconSize: 35,
                    onPressed: (){
                      setState(() {
                        mapController.move(locs.userPos, 15);
                      });

                    },
                ),
              ),
            ),
          ),
        ],
      ),

      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBarHome(
        scaffoldKey: _scaffoldKey,
        menu_button: menu_button,
        marker_list: marker_list,
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );

  }

  AlertDialog countySelect() {
    return AlertDialog(
      title: const Text('Filter by County'),
      content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ToggleButtons(
                children: locs.fullCounties.map<Text>((e) => Text(e)).toList(),
                onPressed: (int index) {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                },
                isSelected: isSelected,
                direction: Axis.vertical,
                //selectedColor: Colors.lightBlueAccent,
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
          onPressed: () {
            setState(() {
              selectedCounties = [];
              for (int i = 0; i < isSelected.length; i++)
                if (isSelected[i]) {
                  selectedCounties.add(locs.fullCounties[i]);
                }
              selectedList = 4;
            });
            Navigator.of(context).pop();

          },
        ),
      ],
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
