import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/src/locations.dart' as locs;
import 'bottom_nav_bar.dart';
import 'side_menu.dart';

class WishListPage extends StatelessWidget {
  WishListPage({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Wishlist Page"),
        backgroundColor: Colors.blueGrey,
      ),
      body: locs.buildWishList(context),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}
