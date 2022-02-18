/*
 * This provides some functionality for the filler my_markers_page.
 * Eventually, this page will show visited markers, perhaps by county, but
 * for now it just allows a user to click on a county name to increment
 * the number below it
 */

import 'package:flutter/material.dart';
import '../markers/marker.dart';

class CountyCollection extends StatefulWidget {
  final String countyName;
  final int markerNum;
  final List<Marker> visited;
  CountyCollection({Key? key, required this.countyName, required this
      .markerNum, required this.visited}) : super(key: key);
  @override
  _CountyCollection createState() => _CountyCollection();
}

class _CountyCollection extends State<CountyCollection> {
  @override
  int counter = 0;
  Widget build(BuildContext context){
    for(var marker in widget.visited){
      if(marker.county.split(" ")[0] == widget.countyName){
        counter++;
      }
    }
    return FittedBox(
        fit: BoxFit.contain, // otherwise the logo will be tiny
        child: Column(
          children: [
            FloatingActionButton(
              backgroundColor: Colors.white70,
              foregroundColor: Colors.blueGrey,
              splashColor: Colors.amber,
              onPressed: () {
                setState(() {
                  if (counter != widget.markerNum)
                    counter++;
                });
              },
              child: const Icon(
                  Icons.star,
                  size: 36.0),
            ),
            Text(
                widget.countyName,
                style: const TextStyle(fontSize: 15)
            ),
            Text(
                '('+counter.toString()+'/'+widget.markerNum.toString()+')',
                style: const TextStyle(fontSize: 10)
            ),
          ],

      )
    );
  }
}

