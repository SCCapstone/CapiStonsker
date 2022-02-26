import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fire_auth.dart';

class EditAccount extends StatefulWidget {
  @override
  _EditAccount createState() => _EditAccount();
}

class _EditAccount extends State<EditAccount> {
  final formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _auth = FirebaseAuth.instance;
  String name = '';
  String bio = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    backgroundColor: Colors.blueGrey,
    elevation: 0,
    ),
          body: Form(
      key: formkey,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.grey[200],
              child: SingleChildScrollView(
                padding:
                EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: '1',
                      child: Text(
                        "Update Profile",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        name = value.toString().trim();
                      },
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Display Name',
                      )
                      /*validator: (value) => (value!.isEmpty)
                          ? ' Please enter email'
                          : null,
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter Your Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),*/
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      /*obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Password";
                        }
                      },
                       */
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        bio = value;
                      },
                      textAlign: TextAlign.center,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your bio',
                      )
                          /*prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.black,
                          )),

                       */
                    ),
                    SizedBox(height: 80),
                    UpdateButton(
                      title: 'Update',
                      ontapp: () async {

                      }

                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
    );

  }
}



class UpdateButton extends StatelessWidget {
  final String title;
  final dynamic  ontapp;

  UpdateButton({required this.title, required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed:
          ontapp,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
          ),
        ),
      ),
    );
  }
}


const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(7.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(7)),
  ),
);