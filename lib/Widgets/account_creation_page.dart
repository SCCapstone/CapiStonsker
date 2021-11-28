import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import '../main.dart';
import 'account_page.dart';

// TODO add firebase, including email + password and Google login capabilities
FirebaseAuth auth = FirebaseAuth.instance;

class AccountForm extends StatefulWidget {
  const AccountForm({Key? key}) : super(key: key);

  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<AccountForm> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'First Name',
                    hintText: 'Enter your First Name',
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Last Name',
                    hintText: 'Enter your Last Name',
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email address',
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
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter a password',
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Password must have at least 8 characters';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blueGrey, borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(
                        context, MaterialPageRoute(builder: (_) => AccountPage()));
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 25),
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