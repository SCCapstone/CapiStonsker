/* This is a test of the locations.dart method calcDist
 * to ensure marker list sorting based on calculated distance from user position is correct
 */

import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:capi_stonsker/markers/marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';


void main() {
  //Unit-testing methods in locs is difficult because
  // it is intended to be a static class (all references point to same instance)
  //Additionally, markers are loaded from Firebase on start
  //TODO For now, a handful of markers are pre-loaded in this test. To fully test, Firebase connection must be established.
  double dist_short;
  locs.markers.add(Marker('BETH SHALOM CEMETERY', '', '', [33.9886, 81.02438333333333], ''));
  locs.markers.add(Marker('EDWARDS V. S.C.', '', '', [34.00143333333333, 81.03375], ''));
  locs.markers.add(Marker('MCCORD HOUSE', '', '', [33.999966666666666, 81.02783333333333], ''));
  locs.markers.add(Marker('SENATE STREET', '', '', [34.0004, 81.03155], ''));

  group('calcDist', ()
  {
    //0,0 will use the saved userpos (user for this app should never be at 0,0), so not tested

    test('Distance to MCCORD HOUSE should be 0.09 (truncated)', () {
      //33.9992, -81.0290; calculation for McCord House 0.09mi
      locs.calcDist(lat: 33.9992, long: -81.0290);
      //Roundabout way, but truncates double for quick comparison
      //TODO get actual stored distances here
      dist_short = double.parse(locs.markers
          .singleWhere((e) => e.name == 'MCCORD HOUSE')
          .userDist
          .toStringAsFixed(2));
      expect(dist_short, 0.09);
    });

    test('Distance to MCCORD HOUSE should be 0.59 (truncated)', () {
      //33.9804, -81.0272; calculation for Beth Shalom Cemetery 0.59mi
      locs.calcDist(lat: 33.9804, long: -81.0272);
      dist_short = double.parse(locs.markers
          .singleWhere((e) => e.name == 'BETH SHALOM CEMETERY')
          .userDist
          .toStringAsFixed(2));
      expect(dist_short, 0.59);
    });

    test('Distance to MCCORD HOUSE should be 1.01 (truncated)', () {
      //34.0038, -81.0512; calculation for Edwards V. S.C. 1.02mi
      locs.calcDist(lat: 34.0038, long: -81.0512);
      dist_short = double.parse(locs.markers
          .singleWhere((e) => e.name == 'EDWARDS V. S.C.')
          .userDist
          .toStringAsFixed(2));
      expect(dist_short, 1.01);
    });

    test('Distance to SENATE STREET should be 3876.28 (truncated)', () {
      //90.0000, -135.0000; North Pole
      locs.calcDist(lat: 90.0000, long: -135.0000);
      dist_short = double.parse(locs.markers
          .singleWhere((e) => e.name == 'SENATE STREET')
          .userDist
          .toStringAsFixed(2));
      expect(dist_short, 3876.28);
    });
  });
}