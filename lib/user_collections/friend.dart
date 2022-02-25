
import 'package:flutter/cupertino.dart' show BuildContext, Icon, ListView, Navigator, Text, Widget;
import 'package:flutter/material.dart';// show IconButton, Icons, ListTile, MaterialPageRoute, ButtonBar;
import 'package:cloud_firestore/cloud_firestore.dart';



class Friend extends Comparable {
  final String email;
  final String uid;
  bool from_me;
  bool has_accepted;

  //Constructor
  Friend(this.email, this.uid, this.from_me, this.has_accepted);

  factory Friend.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    return Friend(doc.id, data['uid'] as String, data['from_me'] as bool, data['has_accepted'] as bool);
  }

  @override
  int compareTo(other) {
    return this.email.compareTo(other.email);
  }

  int pendingSort(Friend other) {
    if (this.from_me != other.from_me) {
      if (this.from_me == true)
        return 1;
      else
        return -1;
    }
    else {
      return 0;
    }
  }

}