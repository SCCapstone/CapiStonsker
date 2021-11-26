import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/src/locations.dart' as locs;
import 'bottom-nav-bar.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wishlist Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: locs.buildWishList(context)
      //bottomNavigationBar: BottomNavBar(),
    );
  }
}
