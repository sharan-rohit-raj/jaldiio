import 'package:flutter/material.dart';
import 'package:jaldiio/ForgotPassword.dart';
import 'package:jaldiio/SignUpPage.dart';
import './Animation/FadeAnimation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff24146d),
      body: Column(
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
                      "Hello there, \nwelcome back",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,

                      ),
                    ),),
                  SizedBox(
                    height: 40,
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
                              hintText: "Username",
                              hintStyle: TextStyle(
                                  color: Colors.grey
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Colors.grey[100],
                            ),
                            ),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border:InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),),
                  SizedBox(
                    height: 50.0,
                  ),
                  FlatButton(
                    color: Color(0xff24146d),
                    child: Center(
                      child:  FadeAnimation(1,
                        Text("Forgot Password?",
                          style: TextStyle(color: Colors.orange[200]
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
                    }
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  FadeAnimation(1,
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromRGBO(109, 93, 191, 0.65)
                      ),
                      child: Center(child: Text("Login", style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                      ),
                    ),),
                  SizedBox(
                    height: 5.0,
                  ),
                  FlatButton(
                      color: Color(0xff24146d),
                      child: Center(
                        child:  FadeAnimation(1,
                          Text("Create Account",
                            style: TextStyle(color: Colors.orange[200]
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      }
                  ),
                ],
              )

          )
        ],
      ),
    );
  }
}