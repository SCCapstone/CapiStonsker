/*
 * This page is accessible from the home page and provides a list view
 * of the markers, sorted by distance from the user.
 *
 * A marker can be navigated to by pressing the nav button
 * to the right of the marker's name
 *
 * Tapping a marker opens that marker's full info page
 */

import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;

class MarkerListPage extends StatefulWidget {
  MarkerListPage({Key? key}) : super(key: key);

  @override
  State<MarkerListPage> createState() => _MarkerListPageState();
}

class _MarkerListPageState extends State<MarkerListPage> {
  final List<String> items = <String>["None","County","Visited","Wishlist"];
  String? selectedDrop;
  List<bool> isSelected = List.filled(46, false);
  List<String> selectedCounties = [];
  int selectedList = 3;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String text = "";
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
        //title: Text("Marker List Page"),
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _controller,
              onChanged: (value) => setState(() {
                text = value;
              }
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    this.setState(() {
                      _controller.text = "";
                      text = "";
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
        backgroundColor: Colors.blueGrey,
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
                  case "Visited": { selectedList = 2; } break;
                  case "Wishlist": { selectedList = 1; } break;
                  default: { selectedList = 3; }
                }
              }),
            )
          )
        ],
      ),
      body: locs.buildListDisplay(context, selectedList, text, counties: selectedCounties),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
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
              for (int i = 0; i < isSelected.length; i++)
                if (isSelected[i])
                  selectedCounties.add(locs.fullCounties[i]);
              selectedList = 4;
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}