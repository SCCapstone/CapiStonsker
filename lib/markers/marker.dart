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
  double userDist = 0.0;
  String id = "none";
  //Should ONLY be used during loadJsonLocal method in locations.dart!
  //ID assigned when uploading to Firebase and all marker info should be received from there.

  //Constructor
  Marker(this.name, this.rel_loc, this.desc, this.gps, this.county, {this.userDist = 0.0, this.id = "none"});
  //Constructs Marker object from dynamic (a map in this code)
  factory Marker.fromJsonLocal(dynamic json) { //JsonLocal does not find an ID, for from Local
    return Marker(json['name'] as String,
        json['rel_loc'] as String,
        json['desc'] as String,
        json['gps'] as List, //Some markers have "No Coordinates"
        json['county'] as String
    );
  }

  factory Marker.fromJson(dynamic json) { //Json does find an ID, for from Firebase
    return Marker(json['name'] as String,
        json['rel_loc'] as String,
        json['desc'] as String,
        json['gps'] as List,
        json['county'] as String,
        id: json['id'] as String
    );
  }

  /*
    Can probably trim this down to just name/id since all
    markers are originally from the imported markers list
    (not changed)
   */
  @override
  bool operator ==(Object other) {
    return (other is Marker) &&
        other.id == id; //TODO May need to adjust back, needs testing
        /*
        other.name == name &&
        other.rel_loc == rel_loc &&
        other.desc == desc &&
        other.county == county &&
        //Can compare like this because there are only two elements
        other.gps.first == gps.first &&
        other.gps.last == gps.last;
         */
  }

}