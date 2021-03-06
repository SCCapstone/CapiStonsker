/*
 * This page displays marker name, description, and county information
 * and also allows a user to add/ remove the marker from their wishlist
 * via fav_button.
 *
 * This page is accessible from the marker_box preview page or from the
 * marker_list page
 */

import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'marker.dart';
import '../user_collections/fav_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'locations.dart' as locs;


class FullInfoPage extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final Marker sentMarker;
  final List<String> picIDs = ["RICHLAND111", "RICHLAND55", "RICHLAND192", "RICHLAND56", "RICHLAND63", "RICHLAND208", "RICHLAND71"];
  FirebaseStorage storage = FirebaseStorage.instance;

  FullInfoPage({Key? key, required this.sentMarker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVis = locs.visitedDupe(sentMarker);

    Widget markerPic = Padding(padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0));
    if (picIDs.contains(sentMarker.id)) {
      markerPic = FutureBuilder(
          future: _loadImage(sentMarker.id),
          builder: (context,
              AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              String imageUrl = snapshot.data!;
                return Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                          child: Ink.image(
                              image: Image.network(imageUrl).image,
                              height: 360,
                              width: 120,
                              fit: BoxFit.cover
                          )
                      )
                    ),
                  );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
      );
    }

    return Scaffold(
      extendBody: true,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }
        ),
        title: Text(sentMarker.name),
        backgroundColor: Colors.blueGrey,
        actions: <Widget>[
          Icon(
            isVis ? Icons.location_on : Icons.location_off_outlined,
            color: Colors.white,//isVis ? Colors.green : Colors.red,
            size: 30.0,
          )
        ]
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [

                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0xFFF5F5F5),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: ListTile(
                            leading: const Icon(
                              Icons.compare_arrows,
                            ),
                            title: Text(
                              sentMarker.rel_loc,
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            subtitle: const Text(
                              'Relative Location',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                            tileColor: const Color(0xFFF5F5F5),
                            dense: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //markerPic is either a 0 size padding or image
                  markerPic,
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0xFFF5F5F5),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: ListTile(
                            title: const Text(
                              'Description',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            subtitle: Text(
                              sentMarker.desc,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal
                              ),
                            ),
                            trailing: const Icon(
                              Icons.article_outlined,
                              color: Color(0xFF303030),
                              size: 20,
                            ),
                            tileColor: const Color(0xFFF5F5F5),
                            dense: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0xFFF5F5F5),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Text(
                          sentMarker.county,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold
                          ),//FlutterFlowTheme.title1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: const Color(0xFFF5F5F5),
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              const Text(
                                'Add to Wishlist',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              FavButton(sentM: sentMarker),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: const SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }

  // Retrieve the image of the marker
  Future<String> _loadImage(String id) async {
    Reference result = await storage.ref("/files/Markers/" + sentMarker.id + ".JPG");
    String fileUrl = await result.getDownloadURL();
    return fileUrl;
  }
}
