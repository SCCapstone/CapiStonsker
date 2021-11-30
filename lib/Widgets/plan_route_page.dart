import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'side_menu.dart';

class PlanRoutePage extends StatelessWidget {
  PlanRoutePage({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Plan Route Page"),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
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
      ),
    );
  }
}



