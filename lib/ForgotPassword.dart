import 'package:flutter/material.dart';
import 'package:jaldiio/LoginPage.dart';
import './Animation/FadeAnimation.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff24146d),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color.fromRGBO(26, 6, 62, 1.0), Color.fromRGBO(51, 0, 111, 1.0), Color.fromRGBO(83, 0, 181, 1.0)]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
            Container(
              height:200,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/fluid_yellow.png")
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),

            SizedBox(
              height:20,
            ),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                      1,
                      Text(
                        "Forgot your password ?",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      1,
                      Text(
                        "No worries, we got you !\nJust enter your email below.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,

                        ),
                      ),
                    ),
                    FadeAnimation(
                      1, Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.grey[100]
                                ),
                              ),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "E-mail",
                                hintStyle: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),),
                    SizedBox(
                      height: 50.0,
                    ),

                    FlatButton(
                      color: Colors.transparent,
                      child: FadeAnimation(1,
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(109, 93, 191, 0.30)
                          ),
                          child: Center(child: Text("Confirm", style: TextStyle(
                            color: Colors.white,
                          ),
                          ),
                          ),
                        ),),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.0,
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