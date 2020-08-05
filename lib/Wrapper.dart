/// ------------------------------------------------------------------------
/// Wrapper.dart
/// ------------------------------------------------------------------------
/// Description: Wrapper class. Sends user to Authenticate() or HomePage()
/// Author(s): Sharan
/// Date Approved: 02/06/2020
/// Date Created: 02/06/2020
/// Approved By: Kaish
/// Reviewed By: Kaish
/// ------------------------------------------------------------------------
/// File(s) Accessed: null
/// File(s) Modified: null
/// ------------------------------------------------------------------------
/// Input(s): FirebaseUser
/// Output(s):
/// ------------------------------------------------------------------------
/// Error-Handling(s): Basic class, no need of any error handling.
/// ------------------------------------------------------------------------
/// Modification(s): None
/// ------------------------------------------------------------------------
/// Fault(s): None
/// ------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:jaldiio/Authentication/Authenticate.dart';
import 'package:provider/provider.dart';
import 'Models/user.dart';
import 'package:jaldiio/HomeSection/HomePage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user_val = Provider.of<User>(context);

    if(user_val == null){
      return Authenticate();
    }
    else{
      return HomePage();
    }

  }
}
