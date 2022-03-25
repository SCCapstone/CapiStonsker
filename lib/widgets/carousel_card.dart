import 'package:flutter/material.dart';

import 'package:capi_stonsker/markers/locations.dart' as locs;

Widget carouselCard(int index, num distance, num duration) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locs.nearby[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 10),
                ),
                const SizedBox(height: 5),
                Text(
                  '${distance.toStringAsFixed(2)}kms, ${duration.toStringAsFixed(2)} mins',
                  style: const TextStyle(color: Colors.blueGrey),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}