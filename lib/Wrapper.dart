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
