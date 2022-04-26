
import 'dart:io';

/*
 * This page is our splash screen, which displays while the app is loading
 */


import 'package:capi_stonsker/ui/error.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart' as locations;
import 'package:capi_stonsker/main.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:latlong2/latlong.dart' as ll;

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;


  bool? _isConnected;

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.github.com');
      if (response.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } on SocketException catch (err) {
      setState(() {
        _isConnected = false;
      });

    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..addListener(() {setState(() {});});
    //Implement animation here
    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);

    _controller.repeat();
    super.initState();
    initializeLocationAndSave();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initializeLocationAndSave() async{

    //await locs.getMarkers();


    await locs.getWish();
    await locs.getVis();

    locations.Location _location = locations.Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await _location.requestService();
    }

    locations.LocationData _locationData = await _location.getLocation();

    LatLng currentLatLng = LatLng(_locationData.latitude!, _locationData.longitude!);
    await locs.updatePos(ll.LatLng(_locationData.latitude!, _locationData.longitude!));


    final response = await InternetAddress.lookup('www.github.com');
    if(response.isNotEmpty){
      Future.delayed(
          const Duration(microseconds: 1),
              () =>
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MyHomePage(isNav: true, waypointLat: waypointLats, waypointLng: waypointLngs,points: path,show: true, popup: true, duration: -1.0, distance: -1.0,))));

    } else{
      Future.delayed(
          const Duration(microseconds: 1),
              () =>
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => errorPage())));


      }
   }


  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key("splash"),
      children: [
        Container(
          height: 550,
          child: Material(
              color: Colors.black,
              child: Center(child: Image.asset('assets/image/logo.PNG')),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: SizedBox(
            height: 60,
            width: 60,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.blueGrey,
              strokeWidth: 8,
            ),
          ),
        ),
      ],
    );
  }
}