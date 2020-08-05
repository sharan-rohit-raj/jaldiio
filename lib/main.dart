/// ------------------------------------------------------------------------
/// main.dart
/// ------------------------------------------------------------------------
/// Description: main class for the app
/// Author(s): Sharan
/// Date Approved: 02/06/2020
/// Date Created: 02/06/2020
/// Approved By: Kaish
/// Reviewed By: Kaish
/// ------------------------------------------------------------------------
/// File(s) Accessed: null
/// File(s) Modified: null
/// ------------------------------------------------------------------------
/// Input(s): null
/// Output(s): null
/// ------------------------------------------------------------------------
/// Error-Handling(s): Nothing, as basic class should work regardless
/// ------------------------------------------------------------------------
/// Modification(s): None
/// ------------------------------------------------------------------------
/// Fault(s): None
/// ------------------------------------------------------------------------
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/FireBaseUser.dart';
import 'package:jaldiio/ToDos/ToDoList.dart';
import 'package:provider/provider.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'ForgotPassword.dart';
import 'Wrapper.dart';
import 'package:google_fonts/google_fonts.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

        return StreamProvider<User>.value(
          value: AuthService().user_stream,

          child: MaterialApp(
            home: Wrapper(),
          ),
        );

  }
}


