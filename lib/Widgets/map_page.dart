import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:capi_stonsker/src/locations.dart' as locs;
import 'package:capi_stonsker/src/marker_box.dart' as mBox;
//import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';

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
    // getUserLocation();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: MapboxMap(
    //   accessToken: 'pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ',
    //   styleString: "https://api.mapbox.com/styles/v1/mtduggan/ckukb9uuk6wcz18p9dxyqd1ps/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ",
    //   initialCameraPosition: CameraPosition(
    //     zoom: 13.0,
    //     target: LatLng(34.0007, -81.0348),
    //   ),
    //   ),
    // );
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
        MarkerLayerOptions(
          markers: [
            Marker(

            )
          ]
        ),
      ]
    );
  }
  // Future<Position> locateUser() async {
  //   return Geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }
  //
  // getUserLocation() async {
  //   Position currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   //currentLocation = await locateUser();
  //   setState(() {
  //     latLng.LatLng _center = latLng.LatLng(currentLocation.latitude, currentLocation.longitude);
  //   });
  //   //print('center $_center');
  // }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
//}
