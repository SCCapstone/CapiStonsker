
import 'dart:convert';

import 'package:location/location.dart' as locations;
import 'package:capi_stonsker/helpers/directions_handler.dart';
import 'package:capi_stonsker/main.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:user_location/user_location.dart';
import 'package:latlong2/latlong.dart' as ll;

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 2), vsync: this,
    );
    //Implement animation here
    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
    
    super.initState();
    initializeLocationAndSave();
  }

  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void initializeLocationAndSave() async{

    await locs.getMarkers();
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

    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('latitude', _locationData.longitude!);

    for(int i =0; i<locs.nearby.length;i++){
      Map modifiedResonse = await getDirectionsAPIResponse(currentLatLng, i);
      saveDirectionsAPIResponse(i, json.encode(modifiedResonse));
    }

    Future.delayed(
        const Duration(seconds: 8),
            () =>
            Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {


    return FadeTransition(
      opacity: _animation,
      child: Material(
        color: Colors.black,
        child: Center(child: Image.asset('assets/image/logo.PNG')),
      ),
    );
  }
}
