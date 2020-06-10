import 'package:flutter/material.dart';
import 'package:jaldiio/LoginPage.dart';
import 'package:jaldiio/Services/auth.dart';
import 'package:jaldiio/WelcomePage.dart';
import './Animation/FadeAnimation.dart';

class SignUpPage extends StatefulWidget {

  final Function toggleView;
  SignUpPage({this.toggleView});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email_id = " ";
  String password = " ";
  String error = '';
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
                      ),
                    ),
                    BackButton(
                      color: Colors.white,
                      onPressed: (){
                          widget.toggleView();
                      },
                    ),
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
                        "Get on Board with us!",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,

                        ),
                      ),),
                    SizedBox(
                      height: 25,
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
                                border: Border(bottom: BorderSide(
                                  color: Colors.grey[100],
                                ),
                                ),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border:InputBorder.none,
                                    hintText: "Email ID",
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                                validator: (val) => val.isEmpty ? 'Enter an Email ID' : null,
                                onChanged: (val){
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
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                                obscureText: true,
                                validator: (val) => val.length < 6 ? 'Enter a Password 6+ characters long' : null, 
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
                                    hintText: "Confirm Password",
                                    hintStyle: TextStyle(color: Colors.grey)
                                ),
                                obscureText: true,
                                validator: (val) => val.length < 6 ? 'Enter a password 6+ characters long' : null,
                                onChanged: (val){
                                  setState(() => password = val);
                                },
                              ),
                            )
                          ],
                        ),
                      ),),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 20.0,
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
                          child: Center(child: Text("Sign Up", style: TextStyle(
                            color: Colors.white,
                          ),
                          ),
                          ),
                        ),),
                      onPressed: () async {
                          if(_formKey.currentState.validate()){
                            dynamic result = await _auth.registerWithEmailAndPassword(email_id, password);

                            if(result == null){
                              setState(() => error = 'Please supply a valid email');
                            }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => WelcomePage()),
                                );
                            }


                          }
                      },
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

            ),

          ],
        ),
      ),
    );
  }
}