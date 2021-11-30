import 'package:capi_stonsker/Widgets/side_menu.dart';
import 'package:capi_stonsker/nav/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("Users");
TextEditingController emailC = TextEditingController();
TextEditingController fnameC = TextEditingController();
TextEditingController lnameC = TextEditingController();
TextEditingController passwordC = TextEditingController();

class AccountCreation extends StatefulWidget {
  AccountCreation({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}
class _State extends State<AccountCreation>{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        shadowColor: Colors.blueGrey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(35),
            )
        ),
        title: const Text('Account Creation'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              AccountForm(),
            ])
        ),
      ),
      drawer: SideMenu(),
      bottomNavigationBar: BottomNavBar(scaffoldKey: _scaffoldKey,),
    );
  }
}

class AccountForm extends StatefulWidget {
  const AccountForm({Key? key}) : super(key: key);

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<AccountForm> {


  @override
  Widget build(BuildContext context) {
    return Form(
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: fnameC,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: lnameC,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: emailC,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                      ),

                      validator: (value) {
                        bool sym;
                        if (value != null && value.contains('@')) {
                          sym = true;
                        }
                        else {
                          sym = false;
                        }
                        if (value == null || value.isEmpty || !sym) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                        controller: emailC,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password.';
                        }
                        return null;
                      },
                    )

                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      height: 50,
                      width: 500,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            createUserWithEmailAndPassword();
                          }
                          },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),


                ]
            )
        )
    );
  }
}



//TODO create account creation form, implement firebase logging and storing

void createUserWithEmailAndPassword() async {
   try {
     UserCredential userCredential = await FirebaseAuth.instance
         .createUserWithEmailAndPassword(
         email: emailC.text,
         password: passwordC.text
     );
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
     }
   } catch (e) {
     print(e);
   }
}



