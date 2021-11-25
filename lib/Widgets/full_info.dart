import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/marker.dart';

class FullInfoPage extends StatelessWidget {
  final Marker sentMarker;

  const FullInfoPage({Key? key, required this.sentMarker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sentMarker.name),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: ElevatedButton(
          //color: Colors.blueGrey,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("button"),
        ),
      ),
    );
  }
}
