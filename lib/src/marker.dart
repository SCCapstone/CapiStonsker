/*
  The Marker class was put into its own file because it will be more
  commonly imported, so this cuts down on extra content that's imported
*/

class Marker {
  //Marker attributes
  final String name;
  final String rel_loc;
  final String desc;
  final List gps;
  final String county;

  //Empty Constructor
  Marker.empty() : this("", "", "", [0,0], "");

  //Constructor
  Marker(this.name, this.rel_loc, this.desc, this.gps, this.county);

  //Constructs Marker object from dynamic (a map in this code)
  factory Marker.fromJson(dynamic json) {
    return Marker(json['name'] as String,
        json['rel_loc'] as String,
        json['desc'] as String,
        json['gps'] as List,
        json['county'] as String);
  }

}