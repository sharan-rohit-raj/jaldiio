/// ------------------------------------------------------------------------
/// Authenticate.dart
/// ------------------------------------------------------------------------
/// Description: Class that decided whether to send user to SignUp or Login
/// Author(s): Sharan
/// Date Approved: 19/06/2020
/// Date Created: 12/06/2020
/// Approved By: Ravish
/// Reviewed By: Kaish
/// ------------------------------------------------------------------------
/// File(s) Accessed: null
/// File(s) Modified: null
/// ------------------------------------------------------------------------
/// Input(s): null
/// Output(s): null
/// ------------------------------------------------------------------------
/// Error-Handling(s): Basic class, no error handling is required.
/// ------------------------------------------------------------------------
/// Modification(s): None
/// ------------------------------------------------------------------------
/// Fault(s): None
/// ------------------------------------------------------------------------
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
