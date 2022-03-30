/*
 * The MapPage Widget acts as the body of main.dart,
 * displaying markers on the home page
 */

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart' as locations;
import 'package:latlong2/latlong.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;
import 'package:capi_stonsker/markers/marker_box.dart' as mBox;
import 'package:capi_stonsker/markers/marker.dart' as mark;
import 'package:user_location/user_location.dart';
import 'package:latlong2/latlong.dart' as ll;

class MapPage extends StatefulWidget {
  int list = 3;
  //1: wishlist, 2: visited, 3: nearby sorted, 4: county
  List<String> counties = [];
  String searchText;
  MapController controller;
  bool popup;
  MapPage({Key? key, required this.popup, required this.list, required this.counties, required this.searchText, required this.controller}) : super(key: key);


  @override
  _MapPageState createState() => _MapPageState();

  void updateList(int num) {
    this.list = num;
  }


}
class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  late UserLocationOptions userLocationOptions;
  List<Marker> uloMarkers = []; //not sure what the UserLayerOptions marker list is for


  @override
  Widget build(BuildContext context) {

    var userLocationOptions = UserLocationOptions(
      context: context,
      markers: uloMarkers,
      updateMapLocationOnPositionChange: false,
      zoomToCurrentLocationOnLoad: true,
      onLocationUpdate: (LatLng pos, double? speed) {
        setState(() {
          //onLocationUpdate is where several different features are going to stem from, likely want to pass into different functions
          locs.updatePos(pos); //Updates userPos variable
        });
      },
      showMoveToCurrentLocationFloatingActionButton: false


    );

    return FlutterMap(
      options: MapOptions(
        maxZoom: 18.0,
        minZoom: 10,
        center: locs.userPos,
        zoom: 15.0,
        plugins: [ UserLocationPlugin(), ],
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/mtduggan/ckukb9uuk6wcz18p9dxyqd1ps/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoibXRkdWdnYW4iLCJhIjoiY2t1a2I4MTV5MWE2MzJ3b2YycGl0djRnZyJ9.Sx7oMnrNlA1yWBO42iSAOQ',
              'id': 'mapbox.satellite',
            }
        ),
        //TODO This currently works, but let's try to find a way to have persistent lists instead of reconstructing every build call
        MarkerLayerOptions(
            markers:
                List<Marker>.filled(1,
                    Marker(
                      rotate: true,
                      width: 50.0,
                      height: 50.0,
                      point: locs.userPos,
                      builder: (ctx) =>
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.my_location_sharp),
                              color: Colors.purple,
                              iconSize: 45.0,
                              onPressed: (){},
                            ),
                          ),
                    )
                ) + selectList().map((m) => mBox.createMapMarker(context, m, widget.popup)).toList(),
        ),
        userLocationOptions,

      ],
      mapController: widget.controller,
    );
  }

  List<mark.Marker> selectList() {
    List<mark.Marker> ret = [];
    switch (widget.list) {
      case 1: { ret = locs.wishlist; } break;
      case 2: {
        ret = locs.visited;
      } break;
      case 3: { ret = locs.markers; } break;
      case 4: {
        for(int i=0;i<widget.counties.length;i++){
          for(int j=0;j<locs.markers.length;j++) {
            if (widget.counties[i].contains(
                locs.markers[j].county.split(new RegExp('\\s+'))[0])) {
              ret.add(locs.markers[j]);
            }
          }
        }
        break;
      }
      case 5: {
        locs.getSearchResults(widget.searchText);
        ret = locs.searchRes;
      } break;
    }
    return ret;
  }
}