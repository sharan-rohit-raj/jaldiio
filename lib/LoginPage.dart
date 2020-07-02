import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/ForgotPassword.dart';
import 'package:jaldiio/Services/auth.dart';
import 'package:jaldiio/Shared/Loading.dart';
import 'package:jaldiio/SignUpPage.dart';
import './Animation/FadeAnimation.dart';

class LoginPage extends StatefulWidget {

  final Function toggleView;
  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state
  String email_id = " ";
  String password = " ";
  String error = '';
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return load == true ? Loading() : Scaffold(
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
                    Form(
                        key: _formKey,
                        child: FadeAnimation(
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
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email ID",
                                  hintStyle: TextStyle(
                                      color: Colors.grey
                                  ),
                                ),
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                validator: (val) => val.isEmpty ? 'Enter an Email ID' : null,
                                onChanged: (val) {
                                    setState(() => email_id = val);
                                },
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
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border:InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.grey),
                                ),
                                style: TextStyle(color: Colors.white, fontSize: 18),
                                obscureText: true,

                                validator: (val) => val.length < 6 ? 'Enter a Password 6+ characters long' : null,
                                onChanged: (val) {
                                     setState(() => password = val);
                                },
                              ),
                            )
                          ],
                        ),
                      ),),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    FlatButton(
                      color: Colors.transparent,
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
                          child: Center(child: Text("Login", style: TextStyle(
                            color: Colors.white,
                          ),
                          ),
                          ),
                        ),),
                      onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() {
                              load = true;
                            });
                            dynamic result = await _auth.signinWithEmailAndPassword(email_id, password);

                            if(result == null){
                              setState(() {
                                error = 'Oh..Oh that seems to be incorrect. Please try again.';
                                load = false;
                              });

                            }
                          }
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    FlatButton(
                        color: Colors.transparent,
                        child: Center(
                          child:  FadeAnimation(1,
                            Text("Create Account",
                              style: TextStyle(color: Colors.orange[200]
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          widget.toggleView();
                        }
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Center(
                        child: Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
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