import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:user_location/user_location.dart';
import 'package:capi_stonsker/markers/locations.dart' as locs;


class NavPage extends StatefulWidget {


  const NavPage({Key? key}) : super(key: key);

  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  MapController mapController = MapController();
  List<Marker> uloMarkers = [];
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          //title: Text("Marker List Page"),

          backgroundColor: Colors.blueGrey,

        ),

        body: FlutterMap(
        options: MapOptions(
          minZoom: 15.0,
          center: LatLng(34.0007, -81.0348),
          zoom: 13.0,
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
          MarkerLayerOptions(
            markers: List<Marker>.filled(1,
                    Marker(
                      width: 45.0,
                      height: 45.0,
                      point: locs.userPos,
                      builder: (ctx) =>
                          Container(
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.blue,
                              iconSize: 45,
                              onPressed: (){},
                            ),
                          ),
                    )
                ),
          ),
          UserLocationOptions(
            context: context,
            mapController: mapController,
            markers: uloMarkers,
            updateMapLocationOnPositionChange: false,
            zoomToCurrentLocationOnLoad: true,
            onLocationUpdate: (LatLng pos, double? speed) {
                setState(() {
                //onLocationUpdate is where several different features are going to stem from, likely want to pass into different functions
                  locs.updatePos(pos); //Updates userPos variable
                });
                },
              moveToCurrentLocationFloatingActionButton: FloatingActionButton(

                onPressed: () {  },
                child: const Icon(Icons.my_location),
              ),
                //showMoveToCurrentLocationFloatingActionButton: true,
          )],
        mapController: mapController,
        )
    );
  }
}




