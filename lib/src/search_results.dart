/*
 * This file creates a page with search results from searching for a marker
 * by name and sorting the results by distance from the user.
 *
 * This is a little janky and will need to be improved in future releases
 */

import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;

class SearchResultsPage extends StatefulWidget {
  SearchResultsPage({Key? key}) : super(key: key);

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  String text = "";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String text = "";
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              onChanged: (value) async {
                text = value;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    // clear search text
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: locs.buildSearch(context, text),//returnText(text)),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}