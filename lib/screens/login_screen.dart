import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/pill_button.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String password;
  String email;

  bool _ShowSpiner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _ShowSpiner,
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
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
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
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter a password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              PillButton(
                fillColor: Colors.lightBlueAccent,
                onPressed: () async {
                  //Go to login screen.
                  try {
                    setState(() {
                      _ShowSpiner = true;
                    });
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    setState(() {
                      _ShowSpiner = false;
                    });
                    if (newUser != null)
                      Navigator.pushNamed(context, ChatScreen.id);
                    print(widget);
                    print('email: $email');
                    print('password: $password');
                  } catch (e) {
                    print(e);
                  }
                },
                title: 'Log In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
