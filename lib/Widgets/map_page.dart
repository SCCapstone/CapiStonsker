import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:capi_stonsker/src/locations.dart' as locs;
import 'package:capi_stonsker/src/marker_box.dart' as mBox;


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  //Creates list of a single boolean for use in the generated toggle button for each marker
  List<List<bool>> isSelectedTop = List.filled(locs.markers.length,
      List<bool>.filled(1, false));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        minZoom: 15.0,
        center: latLng.LatLng(34.0007, -81.0348),
        zoom: 13.0,
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
      ]
    );
  }
}
