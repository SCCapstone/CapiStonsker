import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: ElevatedButton(
          //color: Colors.blueGrey,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Go back home"),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
