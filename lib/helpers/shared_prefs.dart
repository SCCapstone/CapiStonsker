/*
* A massive thanks to the following modifications from this repo:
 * Code modified from:
 *      https://github.com/Imperial-lord/mapbox-flutter
 *      2022 AB Satyaprakash
 */

import 'dart:convert';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:capi_stonsker/main.dart';

LatLng getLatLngFromSharedPrefs() {
  return LatLng(sharedPreferences.getDouble('latitude')!,
      sharedPreferences.getDouble('longitude')!);
}

Map getDecodedResponseFromSharedPrefs(int index) {
  String key = 'marker--$index';
  Map response = json.decode(sharedPreferences.getString(key)!);
  return response;
}

num getDistanceFromSharedPrefs(int index) {
  num distance = getDecodedResponseFromSharedPrefs(index)['distance'];
  return distance;
}

num getDurationFromSharedPrefs(int index) {
  num duration = getDecodedResponseFromSharedPrefs(index)['duration'];
  return duration;
}

Map getGeometryFromSharedPrefs(int index) {
  Map geometry = getDecodedResponseFromSharedPrefs(index)['geometry'];
  return geometry;
}