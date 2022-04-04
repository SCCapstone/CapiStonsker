import 'package:capi_stonsker/auth/take_picture_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import 'account_page.dart';
import 'fire_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
class EditAccount extends StatefulWidget {
  @override
  _EditAccount createState() => _EditAccount();
}

class _EditAccount extends State<EditAccount> {
  final formkey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _auth = FirebaseAuth.instance;
  String name = "";
  String bioV = "";

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

                      ),
                      SizedBox(height: 30),
                      TextFormField(
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            bioV = value.toString().trim();
                          },
                          textAlign: TextAlign.center,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your bio',
                          )

                      ),
                      SizedBox(height: 40),
                      ProfilePictureButton(),
                      SizedBox(height: 80),
                      UpdateButton(
                          title: 'Update',
                          ontapp: () async {

                            auth.currentUser!.updateDisplayName(name);

                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(FireAuth.auth.currentUser!.uid)
                                .set(<String, dynamic>{'bio': bioV});

                            await auth.currentUser!.reload();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountPage()
                                )
                            );


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

// Account Photo Button
class ProfilePictureButton extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: (){
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                      height: 100,
                      child: Column(children: <Widget>[
                        ElevatedButton(
                          child: const Text('Take Picture'),
                          onPressed: () => {
                            Navigator.pop(context),
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => TakePictureScreen(camera:
                                    cameras.first)
                                )
                            )
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                          ),
                        ),
                        ElevatedButton(
                          child: const Text('Choose Photo from '
                              'Library'),
                          onPressed: () async {
                            // Try to take the picture
                            try {
                              final gallery_image = await _picker
                                  .pickImage(source: ImageSource
                                  .gallery);

                              // If the picture was chosen display
                              if (gallery_image != null)
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DisplayPictureScreen(
                                      imagePath: gallery_image.path,
                                    ),
                                  ),
                                );
                            } catch (e) {
                              // If an error occurs, log the error to the console.
                              print(e);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                          ),
                        ),
                      ])
                  );
                }
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Change Profile Picture",
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
