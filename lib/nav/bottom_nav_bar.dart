import 'package:capi_stonsker/Widgets/marker_list_page.dart';
import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                widget.scaffoldKey.currentState!.openDrawer()},
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height*.1,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            IconButton(
              tooltip: 'Map View',
              icon: const Icon(Icons.map),
              iconSize: 40,
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBarHome extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const BottomNavBarHome({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _BottomNavBarHomeState createState() => _BottomNavBarHomeState();
}

class _BottomNavBarHomeState extends State<BottomNavBarHome> {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                widget.scaffoldKey.currentState!.openDrawer()
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SideMenu()
                //   )
              },
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
    );
  }
}

showMenu() {

}