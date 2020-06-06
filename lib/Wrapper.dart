import 'package:flutter/material.dart';
import 'package:jaldiio/Authentication/Authenticate.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'Models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user_val = Provider.of<User>(context);

    if(user_val == null){
      return Authenticate();
    }
    else{
      return Home();
    }

  }
}
