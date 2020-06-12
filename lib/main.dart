import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/auth.dart';
import 'package:jaldiio/ToDoList.dart';
import 'package:provider/provider.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
import 'WelcomePage.dart';
import 'ForgotPassword.dart';
import 'Wrapper.dart';
import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';


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


