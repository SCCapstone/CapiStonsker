import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:capi_stonsker/main.dart';
import '../requests/mapbox_requests.dart';

Future<Map> getDirectionsAPIResponse(LatLng currentLatLng, int index) async {



  final response = await getWalkingRouteUsingMapbox(
      currentLatLng,
      LatLng(locs.nearby[index].gps[0],
          -1.0 * locs.nearby[index].gps[1]));
  Map geometry = response['routes'][0]['geometry'];

  num duration = response['routes'][0]['duration'];

  num distance = response['routes'][0]['distance'];



  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };
  return modifiedResponse;
}

void saveDirectionsAPIResponse(int index, String response) {
  sharedPreferences.setString('marker--$index', response);
}