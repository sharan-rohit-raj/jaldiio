import 'package:flutter/material.dart';
import 'package:jaldiio/LoginPage.dart';
import 'package:jaldiio/SignUpPage.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool signIn = true;
  void toggleView(){
    setState(() => signIn = !signIn);
  }

  @override
  Widget build(BuildContext context) {
    if(signIn)
      return LoginPage(toggleView: toggleView);
    else
      return SignUpPage(toggleView: toggleView);

  }
}
