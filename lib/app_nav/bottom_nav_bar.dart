/*
 * This page implements a bottom navigation bar BottomNavBar
 * to allow easy navigation to the home page and side menu from every page.
 *
 * This page also implements a similar nav bar, BottomNavBarHome
 * so the home page can easily jump to the marker_list page,
 * which is a list view of the same marker information on the home map
 */

import 'package:capi_stonsker/main.dart';
import 'package:capi_stonsker/markers/marker_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final double icon_size = 30;

// Navigation bar for every page except the home page
class BottomNavBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const BottomNavBar({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0x00ffffff),//const Color(0x00000000),//Colors.blueGrey,
      child: IconTheme(
        data: const IconThemeData(color: Colors.white),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.blueGrey,
            radius: icon_size,
            child: IconButton(
                key: const Key('menuview'),
                tooltip: 'Open Menu',
                icon: const Icon(Icons.menu, color: Colors.white),
                iconSize: icon_size,
                onPressed: () => {
                  widget.scaffoldKey.currentState!.openDrawer()},
              ),
          ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height*.1,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          CircleAvatar(
            backgroundColor: Colors.blueGrey,
            radius: icon_size,
            child: IconButton(
                key: const Key('mapview'),
                tooltip: 'Map View',
                icon: const Icon(Icons.map, color: Colors.white),
                iconSize: icon_size,
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage()
                      )
                  );
                },
              ),
          ),
          ],
        ),
      ),
    );
  }
}

// Navigation bar for the home page
class BottomNavBarHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey menu_button = GlobalKey();
  GlobalKey marker_list = GlobalKey();
  BottomNavBarHome({Key? key, required this.scaffoldKey,
    Key? key1, required this.menu_button,
    Key? key2, required this.marker_list})
      : super(key: key);

  @override
  _BottomNavBarHomeState createState() => _BottomNavBarHomeState();
}

class _BottomNavBarHomeState extends State<BottomNavBarHome> {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,//const Color(0x00000000),//Colors.blueGrey,
      child: IconTheme(
        data: const IconThemeData(color: Colors.white),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: icon_size,
              child: IconButton(
                key: widget.menu_button,
                tooltip: 'Open Menu',
                icon: const Icon(Icons.menu, color: Colors.white),
                iconSize: icon_size,
                onPressed: () => {
                  widget.scaffoldKey.currentState!.openDrawer()
                },
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height*.1,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: icon_size,
              child: IconButton(
                key: widget.marker_list,
                tooltip: 'List View',
                icon: const Icon(Icons.list, color: Colors.white),
                iconSize: icon_size,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MarkerListPage()
                      )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}