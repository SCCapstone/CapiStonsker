/*
 * This page implements a button to add or remove a marker to/from a
 * user-specific wishlist
 *
 * This is implemented on the marker preview pane as well as the full info page
 */

import 'package:flutter/material.dart';
import '../markers/marker.dart';
import '../markers/locations.dart' as locs;
import 'package:capi_stonsker/auth/fire_auth.dart';

class FavButton extends StatefulWidget {
  final Marker sentM;

  FavButton({Key? key, required this.sentM}) : super(key: key);

  @override
  _FavButtonState createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  @override
  Widget build(BuildContext context) {
    bool loggedIn = FireAuth.auth.currentUser != null;
    bool inWish = locs.wishDupe(widget.sentM);

    return IconButton(
      icon: (loggedIn && inWish) ? Icon(Icons.star) : Icon(Icons.star_border),
      onPressed: () {
        setState(() {
          if (loggedIn) {
            if (!inWish) {
              locs.addToWish(widget.sentM);
            }
            else {
              locs.removeWishFirebase(widget.sentM);
            }
          }
          else {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('You are not logged in.'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('Please log in to save markers to your wishlist.'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }
        });
      },
    );
  }
}