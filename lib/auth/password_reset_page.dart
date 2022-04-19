/*
 * This page allows a user to reset password
 */

import 'package:capi_stonsker/app_nav/side_menu.dart';
import 'package:capi_stonsker/app_nav/bottom_nav_bar.dart';
import 'package:capi_stonsker/auth/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:capi_stonsker/auth/sign_up_page.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPass createState() => _ForgotPass();
}

class _ForgotPass extends State<ForgotPass> {
  final formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String email = '';
  bool isloading = false;
  static String id = 'forgot-password';
  final String message =
      "An email has just been sent to you. Click the link provided to complete password reset";
  _passwordReset() async {
    try {
      formkey.currentState?.save();
      final user = await auth.sendPasswordResetEmail(email: email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return popUp(context);
        }),
      );
    } catch (e) {
      print(e);
    }
  }

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
        title: Text("Reset Password"),
        backgroundColor: Colors.blueGrey,
      ),
      body: isloading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Form(
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
                      Text(
                        "Reset Password",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Email";
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 80),
                      loginSignupButton(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }

  Widget loginSignupButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: () async {
            {
              if (formkey.currentState!.validate()) {
                setState(() {
                  isloading = true;
                });
                //try {
                _passwordReset();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return LoginScreen();

                  }),
                );
                setState(() {
                  isloading = false;
                });
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Send Reset Email',
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

popUp(context){
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Password Reset'),
      content: const Text("An email has just been sent to you. Click the link provided to complete password reset."),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ForgotPass()),
          ),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}