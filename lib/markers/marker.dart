/*
 * This class creates a marker object that is used throughout the app
 *
 * The Marker class was put into its own file because it will be
 * frequently imported, so this cuts down on extra content that is imported
 */

class Marker {
  //Marker attributes
  final String name;
  final String rel_loc;
  final String desc;
  final List gps;
  final String county;
  double userDist;

  //Constructor
  Marker(this.name, this.rel_loc, this.desc, this.gps, this.county, {this.userDist = 0.0});
  //Constructs Marker object from dynamic (a map in this code)
  factory Marker.fromJson(dynamic json) {
    return Marker(json['name'] as String,
        json['rel_loc'] as String,
        json['desc'] as String,
        json['gps'] as List,
        json['county'] as String);
  }

  /*
    Can probably trim this down to just name since all
    markers are originally from the imported markers list
    (not changed)
   */
  @override
  bool operator ==(Object other) {
    return (other is Marker) &&
        other.name == name &&
        other.rel_loc == rel_loc &&
        other.desc == desc &&
        other.county == county &&
        //Can compare like this because there are only two elements
        other.gps.first == gps.first &&
        other.gps.last == gps.last;
  }

}