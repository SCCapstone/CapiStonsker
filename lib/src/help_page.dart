/*
 * This page provides a list of FAQs and their answers
 *
 * We plan to implement the ability to access the tutorial from this page
 * and to email a system admin with additional issues, but as of the
 * Proof of Concept milestone, these features are not yet implemented
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

final ques = FirebaseFirestore.instance.collection('FAQs');
List<FAQ> faqs = [];//FAQ('q','a')];

class FAQ {
  final String q;
  final String a;
  //String id = "none";
  FAQ(this.q, this.a);//, {this.id = "none"});
  // factory FAQ.fromJson(dynamic json) {
  //   return FAQ(
  //       json['Question'] as String,
  //       json['Answer'] as String,
  //       id: json['id'] as String
  //   );
  // }
  String get_q() {
    return q;
  }
  String get_a() {
    return a;
  }
}

getFAQs() async {
  QuerySnapshot snapshot = await ques.get();
  snapshot.docs.forEach((doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    faqs.add(FAQ(data['Question'], data['Answer']));
  });
}

launchMailto() async {
  final mailtoLink = Mailto(
    to: ['capistonsker@gmail.com'],
    subject: 'Question for CapiStonsker App',
    body: 'Ask your question here...',
  );
  await launch('$mailtoLink');
}

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    getFAQs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('FAQs').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              extendBody: true,
              key: _scaffoldKey,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: new IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                ),
                title: Text("Help Page"),
                backgroundColor: Colors.blueGrey,
              ),
              body: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                      child: Text(
                        "Frequently Asked Questions",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        "",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                          ),
                          onPressed: () {
                            launchMailto();
                          },
                          child: Text(
                            "ASK FOR HELP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
              drawer: SideMenu(),
              bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
            );
          } else {
            return Scaffold(
              extendBody: true,
              key: _scaffoldKey,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: new IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                ),
                title: Text("Help Page"),
                backgroundColor: Colors.blueGrey,
              ),
              body: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                      child: Text(
                        "Frequently Asked Questions",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        //"",
                        faqs.elementAt(0).get_q(),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            //"",
                            faqs.elementAt(0).get_a(),
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                          faqs.elementAt(1).get_q(),
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                      ),
                      children: <Widget>[
                        ListTile(
                            title: Text(
                                faqs.elementAt(1).get_a(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                            ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        faqs.elementAt(2).get_q(),
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      // subtitle: Text('Some other text...'),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            faqs.elementAt(2).get_a(),
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                      child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                          ),
                          onPressed: () {
                            launchMailto();
                          },
                          child: Text(
                            "ASK FOR HELP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ]
              ),
              drawer: SideMenu(),
              bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
            );
          }
        }
    );
  }
}