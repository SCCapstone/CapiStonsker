import 'package:capi_stonsker/ui/splash.dart';
import 'package:flutter/material.dart';

class errorPage extends StatefulWidget {
  const errorPage({Key? key}) : super(key: key);

  @override
  State<errorPage> createState() => _errorPageState();
}

class _errorPageState extends State<errorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Message"),
      ),
      body: Center(
        child: Text("Not Connected to Internet. Connect and try again."),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () {
          // Update the state of the app
          // ...
          // Then close the drawer
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => new Splash()
              )
          );
        }
      )
    );
  }
}
