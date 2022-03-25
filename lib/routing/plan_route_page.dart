/*
 * The idea of this page is to plan complex routes, such as routes that
 * visit multiple different markers
 *
 * This page is not yet implemented as of the Proof of Concept release
 *
 * Consider: we may end up removing this page and not implementing this feature
 *
 * A massive thanks to the following modifications from this repo:
 * Code modified from:
 *      https://github.com/Imperial-lord/mapbox-flutter
 *      2022 AB Satyaprakash
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/shared_prefs.dart';
import '../widgets/carousel_card.dart';

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
  List<Map> carouselData = [];

  int pageIndex = 0;
  late List<Widget> carouselItems;

  late List<CameraPosition> _kMarkersList;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 16);


    for(int i = 0; i < locs.nearby.length; i++){
      num distance = getDistanceFromSharedPrefs(i)/1000;
      num duration = getDistanceFromSharedPrefs(i)/60;
      carouselData.add({'index': i, 'distance': distance, 'duration': duration});
    }

    carouselItems = List<Widget>.generate(locs.nearby.length, (index) => carouselCard(carouselData[index]['index'],
        carouselData[index]['distance'],
        carouselData[index]['duration']));


    _kMarkersList = List<CameraPosition>.generate(locs.nearby.length, (index) =>
        CameraPosition(target: LatLng(locs.nearby[index].gps[0], -1.0 * locs.nearby[index].gps[1]),
          zoom: 15
        )
    );
  }

  _addSourceAndLineLayer(int index, bool removeLayer) async{

    controller.animateCamera(CameraUpdate.newCameraPosition(_kMarkersList[index]));

    Map geometry = getGeometryFromSharedPrefs(carouselData[index]['index']);
    final _fills = {
      "type": "FeatureCollection",
      "features":[
        {
          "type":"Feature",
          "id":0,
          "properties": <String, dynamic>{},
          "geometry":geometry
        }
      ]
    };

    if(removeLayer == true){
      await controller.removeLayer("lines");
      await controller.removeSource("fills");
    }

    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer("fills", "lines", LineLayerProperties(
      lineColor: Colors.green.toHexStringRGB(),
      lineCap: "round",
      lineJoin: "round",
      lineWidth: 10
    ));
  }

  _onStyleLoadedCallback() async{
    for(CameraPosition _kMarker in _kMarkersList){
      controller.addSymbol(SymbolOptions(
        iconImage: 'assets/image/marker.PNG',
        iconSize: .4,
        geometry: _kMarker.target,
      ));
    }
    _addSourceAndLineLayer(0, false);
  }

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
      body: Stack(
            children: [
              MapboxMap(
                    initialCameraPosition: _initialCameraPosition,
                    accessToken: 'pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ',
                    onMapCreated: _onMapCreated,
                    onStyleLoadedCallback: _onStyleLoadedCallback,
                    myLocationEnabled: true,
                    myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                    minMaxZoomPreference: MinMaxZoomPreference(10,18),
              ),
              CarouselSlider(items: carouselItems, options: CarouselOptions(
                height: 100,
                viewportFraction: 0.6,
                initialPage: 0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (int index, CarouselPageChangedReason reason){
                  setState(() {
                    pageIndex = index;
                  });
                  _addSourceAndLineLayer(index, true);
                }
              ),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 25,
                    child: IconButton(
                      //key: widget.menu_button,
                      //tooltip: 'Open Menu',
                      icon: Icon(Icons.my_location),
                      color: Colors.white,
                      iconSize: 35,
                      onPressed: (){
                        controller.animateCamera(CameraUpdate.newCameraPosition(_initialCameraPosition),);
                      },
                    ),
                  ),
                ),
              ),
            ],

          ),

    );
  }
}









