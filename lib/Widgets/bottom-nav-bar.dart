import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'marker_list_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

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
                // TODO: Show the side menu,
                // SideMenu.openDrawer(Gravity.START),
                // Navigator.push(context, SideMenu()),
                //endDrawer: SideMenu(),
                // Scaffold.of(context).openDrawer(),
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
