import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    required this.lat,
    required this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

// @JsonSerializable()
// class County {
//   County({
//     required this.coords,
//     required this.county,
//   });
//
//   factory County.fromJson(Map<String, dynamic> json) => _$CountyFromJson(json);
//   Map<String, dynamic> toJson() => _$CountyToJson(this);
//
//   final LatLng coords;
//   final String county;
// }

@JsonSerializable()
class Place {
  Place({
    required this.name,
    required this.id,
    required this.rel_loc,
    required this.desc,
    required this.lat,
    required this.lng,
    required this.county,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  final String name;
  final String id;
  final String rel_loc;
  final String desc;
  final double lat;
  final double lng;
  final String county;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.places,
    //required this.counties,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Place> places;
//final List<County> counties;
}

Future<Locations> getLocalPlaces() async {
  // const googleLocationsURL = 'https://about.google/static/data/locations.json';
  //
  // // Retrieve the locations of Google offices
  // try {
  //   final response = await http.get(Uri.parse(googleLocationsURL));
  //   if (response.statusCode == 200) {
  //     return Locations.fromJson(json.decode(response.body));
  //   }
  // } catch (e) {
  //   print(e);
  // }

  // Fallback for when the above HTTP request fails.
  return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('assets/locations.json'),
    ),
  );
}