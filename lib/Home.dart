import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jaldiio/Services/auth.dart';
import './Animation/FadeAnimation.dart';
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text("Jaldi.io"),
        backgroundColor: Color.fromRGBO(32, 6, 62, 1),
      elevation: 0.0,
      actions: <Widget>[
        FlatButton.icon(
          onPressed: () async{
              await _auth.signOut();
          },
          icon: Icon(Icons.person),
          label: Text('Sign Out'),
          color: Colors.white,
        ),
      ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    FadeAnimation(
                      1,
                      Text(
                        "Welcome user!",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,

                        ),
                      ),),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                )

            )
          ],
        ),
      ),
    );
  }
}

