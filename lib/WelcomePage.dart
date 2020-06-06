import 'package:flutter/material.dart';
import 'package:jaldiio/LoginPage.dart';
import './Animation/FadeAnimation.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
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
                        "Welcome Aboard !",
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
                        "Press Continue to begin creating your own family group!",
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
                          child: Center(child: Text("Continue", style: TextStyle(
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