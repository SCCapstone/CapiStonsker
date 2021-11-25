import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'full_info.dart';
import '../src/locations.dart' as locs;
import 'bottom-nav-bar.dart';

class MarkerListPage extends StatefulWidget {
  const MarkerListPage({Key? key}) : super(key: key);

  @override
  State<MarkerListPage> createState() => _MarkerListPageState();
}

class _MarkerListPageState extends State<MarkerListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marker List Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: locs.buildMarkers(context),
      //bottomNavigationBar: BottomNavBar(),
    );
  }


}
