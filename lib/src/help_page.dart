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
      body: Container(
          child: Column(
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
                      'Question 1....',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                  ),
                  // subtitle: Text('Some other text...'),
                  children: <Widget>[
                    ListTile(
                        title: Text(
                            'Answer to question 1',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                        ),
                    ),
                  ],
                ),
                const ExpansionTile(
                  title: Text(
                      'Question 2....',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                  ),
                  // subtitle: Text('Some other text...'),
                  children: <Widget>[
                    ListTile(
                        title: Text(
                            'Answer to question 2',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                        ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: Text(
                    "TODO: Add a way to access the tutorial",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                  child: ButtonTheme(
                      // TODO figure out how to make button the width of the screen
                      minWidth: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                        ),
                        onPressed: () {
                          // TODO create a link to send an email asking for help
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
          )
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}