import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/LoginPage.dart';
import 'package:string_validator/string_validator.dart';
import './Animation/FadeAnimation.dart';
import 'package:jaldiio/LoginPage.dart';

class ForgotPassword extends StatefulWidget {


  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email_id = " ";

  Future _checkForInternetConnection() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }

  }

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
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.deepPurpleAccent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
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
                    SizedBox(
                      height: 50,
                    ),
                    FadeAnimation(
                      1, Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      child: Form(
                        key: _formKey,
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
                                  hintText: "E-mail",
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
                                validator: (val) => !isEmail(val) ? 'Enter a valid Email ID' : null,
                                onChanged: (val){
                                  setState(() => email_id = val);
                                },
                              ),
                            ),
                          ],
                        ),
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
                      onPressed: () async {
                        if(await _checkForInternetConnection()){
                          if(_formKey.currentState.validate()){
                            FirebaseAuth.instance.sendPasswordResetEmail(email: email_id).then((value) => print("Password link has been sent to the registered Email-ID."));
                          }
                        }else{
                          connectivityDialogBox();
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                        child: Text(
                        error,
                        style: TextStyle(color: Colors.orange[300], fontSize: 14.0),
                      ),
                    ),
                  ],
                ),

            )
          ],
        ),
      ),
    );
  }

  //Connectivity Error Dialog Box
  AwesomeDialog connectivityDialogBox(){
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Connectivity Error',
      desc: 'Hmm..looks like there is no connectivity...',
      btnOkOnPress: () {},
    )..show();
  }
}