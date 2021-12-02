import 'package:flutter/material.dart';
import 'marker.dart';
import 'locations.dart' as locs;

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
          if (!locs.wishDupe(widget.sentM)) {
            locs.addToWish(widget.sentM);
          }
          else {
            locs.removeWishFirebase(widget.sentM);
          }
          //print(locs.wishlist.toString());
        });
      },
    );
  }
}