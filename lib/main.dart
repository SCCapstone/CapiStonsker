//Change to Main by Joe for Source Control Milestone.

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;
import 'dart:async';
//Import firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Historical Markers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow,
        ),
      ),
      home: MyMap(),
    );
  }
}

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final Map<String, Marker> _markers = {};
  final _savedMarkers = <Marker>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final localPlaces = await locations.getLocalPlaces();
    setState(() {
      _markers.clear();
      for (final place in localPlaces.places) {
        final marker = Marker(
          markerId: MarkerId(place.id),
          position: LatLng(place.lat, place.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.desc,
          ),
        );
        _markers[place.name] = marker;
        _savedMarkers.add(marker);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Local Historical Markers'),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: _viewList,
              tooltip: 'Historical Markers List',
            ),
          ],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(34.003327, -81.033010),
            zoom: 12,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }

  void _viewList() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _savedMarkers.map(
                (marker) {
              return ListTile(
                title: Text(
                  marker.infoWindow.title.toString(),
                  style: _biggerFont,
                ),
                subtitle: Text(
                  marker.infoWindow.snippet.toString(),
                ),
                trailing: const Icon(
                  Icons.favorite,
                  color: null,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Historical Markers List'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}