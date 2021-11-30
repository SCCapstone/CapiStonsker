import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'achievement_county.dart';
import 'marker_list_page.dart';
import 'side_menu.dart';

class MyMarkersPage extends StatelessWidget {
  int _counter = 0;

  void _incrementCounter() {
      _counter++;
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("My Markers Page"),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: false,
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
              CountyMark(countyName: 'ABBEVILLE',markerNum: 23),
              CountyMark(countyName: "AIKEN", markerNum: 68),
              CountyMark(countyName: "ALLENDALE", markerNum: 18),
              CountyMark(countyName: 'ANDERSON',markerNum: 48),
              CountyMark(countyName: "BAMBERG", markerNum: 18),
              CountyMark(countyName: "BARNWELL", markerNum: 17),
              CountyMark(countyName: 'BEAUFORT',markerNum: 67),
              CountyMark(countyName: "BERKELEY", markerNum: 75),
              CountyMark(countyName: "CALHOUN", markerNum: 23),
              CountyMark(countyName: 'CHARLESTON',markerNum: 117),
              CountyMark(countyName: "CHEROKEE", markerNum: 13),
              CountyMark(countyName: "CHESTER", markerNum: 10),
              CountyMark(countyName: 'CHESTERFIELD',markerNum: 23),
              CountyMark(countyName: "CLAREDON", markerNum: 27),
              CountyMark(countyName: "COLLETON", markerNum: 21),
              CountyMark(countyName: 'DARLINGTON',markerNum: 85),
              CountyMark(countyName: "DILLON", markerNum: 18),
              CountyMark(countyName: "DORCHESTER", markerNum: 29),
              CountyMark(countyName: 'EDGEFIELD',markerNum: 24),
              CountyMark(countyName: "FAIRFIELD", markerNum: 24),
              CountyMark(countyName: "FLORENCE", markerNum: 51),
              CountyMark(countyName: 'GEORGETOWN',markerNum: 69),
              CountyMark(countyName: "GREENVILLE", markerNum: 91),
              CountyMark(countyName: "GREENWOOD", markerNum: 22),
              CountyMark(countyName: 'HAMPTON',markerNum: 28),
              CountyMark(countyName: "HORRY", markerNum: 31),
              CountyMark(countyName: "JASPER", markerNum: 27),
              CountyMark(countyName: 'KERSHAW',markerNum: 21),
              CountyMark(countyName: "LANCASTER", markerNum: 34),
              CountyMark(countyName: "LAURENS", markerNum: 21),
              CountyMark(countyName: 'LEE',markerNum: 21),
              CountyMark(countyName: "LEXINGTON", markerNum: 46),
              CountyMark(countyName: "MARION", markerNum: 21),
              CountyMark(countyName: 'MARLBORO',markerNum: 43),
              CountyMark(countyName: "MCCORMICK", markerNum: 12),
              CountyMark(countyName: "NEWBERRY", markerNum: 28),
              CountyMark(countyName: 'OCONEE',markerNum: 23),
              CountyMark(countyName: "ORANGEBURG", markerNum: 48),
              CountyMark(countyName: "PICKENS", markerNum: 25),
              CountyMark(countyName: 'RICHLAND',markerNum: 208),
              CountyMark(countyName: "SALUDA", markerNum: 16),
              CountyMark(countyName: "SPARTANBURG", markerNum: 37),
              CountyMark(countyName: 'SUMTER',markerNum: 51),
              CountyMark(countyName: "UNION", markerNum: 20),
              CountyMark(countyName: "WILLIAMSBURG", markerNum: 26),
              CountyMark(countyName: 'YORK',markerNum: 72),
            ],
          )
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
                    _scaffoldKey.currentState!.openDrawer(),
                  }
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