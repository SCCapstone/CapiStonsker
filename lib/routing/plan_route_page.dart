/*
 * The idea of this page is to plan complex routes, such as routes that
 * visit multiple different markers
 *
 * This page is not yet implemented as of the Proof of Concept release
 *
 * Consider: we may end up removing this page and not implementing this feature
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class PlanRoutePage extends StatefulWidget {
  PlanRoutePage({Key? key}) : super(key: key);
  @override
  State<PlanRoutePage> createState() => _PlanRoutePage();
}

class _PlanRoutePage extends State<PlanRoutePage>{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  LatLng latLng = LatLng(locs.userPos.latitude, locs.userPos.longitude);
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 13);
  }


  _onStyleLoadedCallback() async{}

  _onMapCreated(MapboxMapController controller) async{
    this.controller = controller;

  }

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
        title: Text("Plan Route Page"),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
      body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height*0.8,
                  child: MapboxMap(
                    initialCameraPosition: _initialCameraPosition,
                    accessToken: 'pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ',
                    onMapCreated: _onMapCreated,
                    onStyleLoadedCallback: _onStyleLoadedCallback,
                    myLocationEnabled: true,
                    myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                    minMaxZoomPreference: MinMaxZoomPreference(10,18),
                  )
              )
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        controller.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition),);
      },
          child: const Icon(Icons.my_location)),
    );
  }
}









