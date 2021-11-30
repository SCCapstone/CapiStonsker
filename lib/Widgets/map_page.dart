import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:capi_stonsker/src/locations.dart' as locs;
import 'package:capi_stonsker/src/marker_box.dart' as mBox;
import 'package:user_location/user_location.dart';

/*
class MapPage extends StatelessWidget {
  MapController mapController = MapController();
  late UserLocationOptions userLocationOptions;
  LatLng userPos = LatLng(0,0);
  List<Marker> markers = []; //likely need to adjust how markers are gotten

  @override
  Widget build(BuildContext context) {
    userLocationOptions = UserLocationOptions(
        context: context,
        mapController: mapController,
        markers: markers,
        updateMapLocationOnPositionChange: false,
        onLocationUpdate: (LatLng pos, double? speed) {
          userPos = pos;
        },
        //showMoveToCurrentLocationFloatingActionButton: true,
      );
    return FlutterMap(
        options: MapOptions(
          minZoom: 15.0,
          center: LatLng(34.0007, -81.0348),
          zoom: 13.0,
          plugins: [ UserLocationPlugin(), ],
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://api.mapbox.com/styles/v1/mtduggan/ckukb9uuk6wcz18p9dxyqd1ps/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ",
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ',
                'id': 'mapbox.satellite',
              }
          ),
          MarkerLayerOptions(
              markers: locs.markers.map((m) =>
                  mBox.createMapMarker(context, m)
              ).toList()
          ),
          userLocationOptions,
        ],
        mapController: mapController,
    );
  }
}
*/



class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  late UserLocationOptions userLocationOptions;
  LatLng userPos = LatLng(0,0);
  List<Marker> markers = []; //likely need to adjust how markers are gotten?


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    userLocationOptions = UserLocationOptions(
      context: context,
      mapController: mapController,
      markers: markers,
      updateMapLocationOnPositionChange: false,
      onLocationUpdate: (LatLng pos, double? speed) {
        setState(() {
          //onLocationUpdate is where several different features are going to stem from, likely want to pass into different functinons
          userPos = pos;
        });
      },
      //showMoveToCurrentLocationFloatingActionButton: true,
    );

    return FlutterMap(
      options: MapOptions(
        minZoom: 15.0,
        center: LatLng(34.0007, -81.0348),
        zoom: 13.0,
        plugins: [ UserLocationPlugin(), ],
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/mtduggan/ckukb9uuk6wcz18p9dxyqd1ps/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ',
              'id': 'mapbox.satellite',
            }
        ),
        MarkerLayerOptions(
            markers: locs.markers.map((m) => mBox.createMapMarker(context, m)).toList() +
                      List<Marker>.filled(1,
                          Marker(
                            width: 45.0,
                            height: 45.0,
                            point: userPos,
                            builder: (ctx) =>
                                Container(
                                  child: IconButton(
                                    icon: Icon(Icons.location_on),
                                    color: Colors.blue,
                                    iconSize: 45,
                                    onPressed: (){},
                                  ),
                                ),
                          )
                      ),
        ),
        userLocationOptions,
      ],
      mapController: mapController,
    );
  }
}