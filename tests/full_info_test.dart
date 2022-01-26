/* This is a test of the full_info.dart page
 * to ensure marker data is being pulled correctly
 */

import 'package:capi_stonsker/markers/full_info.dart';
import 'package:capi_stonsker/markers/marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final Marker testMarker = Marker('name', 'location', 'description', [1.0,0.0], 'county');

void main() {
  // Widget testWidget = new MediaQuery(
  //     data: new MediaQueryData(),
  //     child: new MaterialApp(home: new FullInfoPage(sentMarker: testMarker))
  // );
  testWidgets('Marker information page is pulling marker data correctly', (WidgetTester tester) async {
    await tester.pumpWidget(new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new FullInfoPage(sentMarker: testMarker))
      ));

    // Ensure name, location, description, and county are properly passed through and displayed
    expect(find.text(testMarker.name), findsOneWidget);
    expect(find.text(testMarker.rel_loc), findsOneWidget);
    expect(find.text(testMarker.desc), findsOneWidget);
    // gps coordinates won't be displayed; instead the distance from current location to marker will
    // TODO: consider checking to make sure distance is being calculated correctly (separate test?)
    expect(find.text(testMarker.county), findsOneWidget);
  });
}