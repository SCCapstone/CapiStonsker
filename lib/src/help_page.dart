/*
 * This page provides a list of FAQs and their answers
 *
 * We plan to implement the ability to access the tutorial from this page
 * and to email a system admin with additional issues, but as of the
 * Proof of Concept milestone, these features are not yet implemented
 */

import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:mailto/mailto.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

launchMailto() async {
  final mailtoLink = Mailto(
    to: ['capistonsker@gmail.com'],
    subject: 'Question for CapiStonsker App',
    body: 'Ask your question here...',
  );
  // Convert the Mailto instance into a string.
  // Use either Dart's string interpolation
  // or the toString() method.
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
  Widget build(BuildContext context) {
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
                const ExpansionTile(
                  title: Text(
                      'Do I need to create an account to use the app?',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                  ),
                  // subtitle: Text('Some other text...'),
                  children: <Widget>[
                    ListTile(
                        title: Text(
                            'You can use this app to find historical landmarks and navigate to them'
                                ' without an account, however, you can create a free account at any'
                                ' time to unlock features such as tracking visited landmarks, adding'
                                ' places to your wishlist, and finding friends.',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                        ),
                    ),
                  ],
                ),
                const ExpansionTile(
                  title: Text(
                      'What options are available to me as a teacher using this app for my class?',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                  ),
                  // subtitle: Text('Some other text...'),
                  children: <Widget>[
                    ListTile(
                        title: Text(
                            'Our app has a built-in friends feature that will allow you'
                                ' to track your students\' progress in visiting any'
                                ' historical landmarks you assign. You can also search'
                                ' for landmarks by name and filter them by county as you'
                                ' search for places your students can visit that are'
                                ' relevant to your particular class.',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                        ),
                    ),
                  ],
                ),
                const ExpansionTile(
                  title: Text(
                    'Is this an app I can feel safe about my children using as a parent?',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  // subtitle: Text('Some other text...'),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'This app is designed to be a fun and educational way to learn and'
                            ' explore your community. Your children will love learning about their'
                            ' community in a fun and interactive way on this platform, and'
                            ' we encoruage you to take them to visit places they learn about'
                            ' on this app. With that said, we recommend that children have'
                            ' parent supervision when visiting unfamilar places. And while'
                            ' we do not have a chat feature between users of our app for'
                            ' safety reasons, we still recommend that parents talk to their'
                            ' children about only friending people they know in real life.',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                //   child: Text(
                //     "TODO: Add a way to access the tutorial",
                //     style: TextStyle(
                //       color: Colors.blueGrey,
                //       fontSize: 30.0,
                //     ),
                //   ),
                // ),

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