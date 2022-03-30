/*
 * This file creates a marker preview pane that is opened when a marker
 * is tapped from the map view. A user can see some information from here
 * and add the marker to their wishlist, or click "SHOW MORE" to go to
 * the full info page for the given marker
 */

import 'package:capi_stonsker/requests/mapbox_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as f_map;
import 'package:latlong2/latlong.dart' as latLng;
import 'package:capi_stonsker/markers/full_info.dart';
import 'package:latlong2/latlong.dart';
import 'marker.dart';
import '../user_collections/fav_button.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:location/location.dart' as locations;
import 'package:latlong2/latlong.dart' as ll;
import 'package:mapbox_gl/mapbox_gl.dart' as mapLL;

class MarkerBox extends StatelessWidget {
  MarkerBox(this.sentM);
  final Marker sentM;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text(sentM.name),
                      subtitle: Text(sentM.rel_loc),
                      isThreeLine: true,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FavButton(sentM: sentM),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('SHOW MORE'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FullInfoPage(
                              sentMarker: sentM,
                            )
                        )
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

f_map.Marker createMapMarker(BuildContext context, Marker m, bool popup) {

  return f_map.Marker(
    rotate: true,
    width: 45.0,
    height: 90.0,
    point: latLng.LatLng(m.gps.first, m.gps.last * -1),
    builder: (ctx) =>
        Container(
          child:
              IconButton(
                padding: const EdgeInsets.only(bottom:45/2),
                icon: Icon(Icons.location_on),
                color: locs.visited.contains(m) ? Colors.green : Colors.red, //If visited list contains Marker, set to green
                iconSize: 45,
                onPressed: () async {
                  if (popup){
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => MarkerBox(m)
                    );
                  }
                  if (!popup){

                  }
                },


          ),
        ),
  );
}
