import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import '../src/marker.dart';
import 'package:capi_stonsker/src/locations.dart' as locs;


class NavPage extends StatefulWidget {
  final Marker sentMarker;
  final double distance;
  const NavPage({Key? key, required this.sentMarker, required this.distance}) : super(key: key);
  @override
  _NavPageState createState() => _NavPageState(
    
  );
}

class _NavPageState extends State<NavPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  
  String _platformVersion = 'Unknown';



  String _instruction = "";
  @override
  void initState() {
    super.initState();
    initialize();
  }



   MapBoxNavigation _directions = new MapBoxNavigation();

  bool _isMultipleStop = false;
  double _distanceRemaining =0.0, _durationRemaining = 0.0;
  late MapBoxNavigationViewController _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  




  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);

  }
  
  @override
  Widget build(BuildContext context) {

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
        title: Text("DIRECTIONS"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text("Start Directions"),
                        onPressed: () async {
                          var wayPoints = <WayPoint>[];
                          wayPoints.add(WayPoint(name: "origin", latitude:  locs.userPos.latitude, longitude:  locs.userPos.longitude));
                          wayPoints.add(WayPoint(name: "marker", latitude: widget.sentMarker.gps.first, longitude:  -widget.sentMarker.gps.last));

                          await _directions.startNavigation(
                              wayPoints: wayPoints,
                              options: MapBoxOptions(
                                  zoom: 15.0,
                                  mode: MapBoxNavigationMode.walking,
                                  simulateRoute: false,
                                  language: "en",
                                  units: VoiceUnits.imperial)
                          );
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20, top: 20, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Distance Remaining: "),
                            Text(_distanceRemaining != null
                                ? "${widget.distance.toStringAsFixed(2)} miles "
                                : "---")
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey,
              child: MapBoxNavigationView(
                  options: MapBoxOptions(
                      zoom: 15.0,
                      tilt: 0.0,
                      bearing: 0.0,
                      enableRefresh: false,
                      alternatives: true,
                      voiceInstructionsEnabled: true,
                      bannerInstructionsEnabled: true,
                      allowsUTurnAtWayPoints: true,
                      mode: MapBoxNavigationMode.walking,
                      mapStyleUrlDay: 'mapbox://styles/mtduggan/ckukb9uuk6wcz18p9dxyqd1ps',
                      mapStyleUrlNight: 'mapbox://styles/mtduggan/ckwp7rxt80nwk14rssj3r9t9f',
                      units: VoiceUnits.imperial,
                      simulateRoute: false,
                      animateBuildRoute: true,
                      longPressDestinationEnabled: true,
                      language: "en"),
                  onRouteEvent: _onRouteEvent,
                  onCreated:
                      (MapBoxNavigationViewController controller) async {
                    _controller = controller;
                    controller.initialize();
                  }),
            ),
          )
        ]),
      ),
    );
  }

  bool _arrived = false;
  Future<void> _onRouteEvent(e) async {

    _distanceRemaining = await _directions.distanceRemaining;
    _durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        _arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction!;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        _routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        _routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        _isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        _arrived = true;
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        _routeBuilt = false;
        _isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }

}
