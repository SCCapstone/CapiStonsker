/*
This ia a test to check the functionality of various elements of the
achievement_counties in the my Markers page. This will test the functionality
of the navigation and filter of the county buttons.
*/


//TODO: Most of this

import 'package:capi_stonsker/user_collections/achievement_county.dart';
import 'package:capi_stonsker/user_collections/my_markers_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // group('Counter', () {
  //   test('value should start at 0', () {
  //     expect(Counter().value, 0);
  //   });

    test('County value should be incremented', () {
      final my_markers = CountyMark(countyName: countyName, markerNum: markerNum);

      counter.increment();

      expect(counter.value, 1);
    });
  });
}