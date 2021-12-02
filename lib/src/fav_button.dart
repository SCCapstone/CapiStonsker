import 'package:flutter/material.dart';
import 'marker.dart';
import 'locations.dart' as locs;
import 'package:capi_stonsker/src/fire_auth.dart';

class FavButton extends StatefulWidget {
  final Marker sentM;

  FavButton({Key? key, required this.sentM}) : super(key: key);

  @override
  _FavButtonState createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: locs.wishDupe(widget.sentM) ? Icon(Icons.star):Icon(Icons.star_border),
      onPressed: () {
        setState(() {
          if (FireAuth.auth.currentUser != null) {
            if (!locs.wishDupe(widget.sentM)) {
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
          //print(locs.wishlist.toString());
        });
      },
    );
  }
}