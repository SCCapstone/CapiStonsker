import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bottom-nav-bar.dart';

class MarkerListPage extends StatelessWidget {
  const MarkerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marker List Page"),
        backgroundColor: Colors.blueGrey,
      ),

        bottomNavigationBar: BottomNavBar(),
    );
  }
}
