import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '/pages/widgets/custom_button.dart';
import '/pages/admin_screen.dart';
import '/pages/user_screen.dart';
import '/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'Login_Screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  bool showSpinner = false;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  void signIn() async {
    setState(() {
      showSpinner = true;
    });
    try {
      final signedUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = _auth.currentUser;
      final userID = user.uid;
      if (signedUser != null) {
        if (_users.doc(userID) != null) {
          _users.doc(userID).get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              if (documentSnapshot['role'] == 'admin') {
                Navigator.pushNamed(context, AdminScreen.id);
              } else {
                Navigator.pushNamed(context, UserScreen.id);
              }
            }
          });
        }
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Center(
                child: Text(
                  'Monitoring Presensi',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
              Center(
                child: Text(
                  'Face Recognition',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              CustomButton(
                title: 'Login',
                color: Colors.blueAccent,
                onPressed: () async {
                  signIn();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
