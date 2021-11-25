import 'package:flutter/material.dart';

class CountyMark extends StatefulWidget {
  final String countyName;
  final int markerNum;
  const CountyMark({Key? key, required this.countyName, required this.markerNum}) : super(key: key);

  @override
  _CountyMarkState createState() => _CountyMarkState();
}

class _CountyMarkState extends State<CountyMark> {
  @override
  int counter = 0;
  Widget build(BuildContext context) {
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

