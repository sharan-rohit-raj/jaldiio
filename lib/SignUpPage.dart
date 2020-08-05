/// ------------------------------------------------------------------------
/// SignUpPage.dart
/// ------------------------------------------------------------------------
/// Description: SignUp page for the app. Creates a User.
/// Author(s): Sharan
/// Date Approved: 02/06/2020
/// Date Created: 02/06/2020
/// Approved By: Kaish
/// Reviewed By: Kaish
/// ------------------------------------------------------------------------
/// File(s) Accessed: null
/// File(s) Modified: null
/// ------------------------------------------------------------------------
/// Input(s): null
/// Output(s): email_id, password
/// ------------------------------------------------------------------------
/// Error-Handling(s): Valid email id, valid password check, internet connectivity
/// ------------------------------------------------------------------------
/// Modification(s): None
/// ------------------------------------------------------------------------
/// Fault(s): None
/// ------------------------------------------------------------------------
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/LoginPage.dart';
import 'package:jaldiio/Services/FireBaseUser.dart';
import 'package:jaldiio/Shared/Loading.dart';
import 'package:string_validator/string_validator.dart';
import './Animation/FadeAnimation.dart';
import 'dart:developer';

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
  String initPassword = "";
  String error = '';
  bool load = false;

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
    return load == true? Loading() : Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.deepPurpleAccent,
                      ),
                      onPressed: () {
                        widget.toggleView();
                      },
                    ),
                  ),

//                    BackButton(
//                      color: Colors.white,
//                      onPressed: (){
////                          widget.toggleView();
//                      print("stop clicking me!");
//                      },

                ],

              ),
            ),



            SizedBox(
              height: 40,
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
                                style: TextStyle(color: Colors.white, fontSize: 18),
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() {
                                    initPassword = val;
                                  });
                                },
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
                                style: TextStyle(color: Colors.white, fontSize: 18),
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

                        if(await _checkForInternetConnection()){
                          if(_formKey.currentState.validate()){
                            if(password.compareTo(initPassword)==0){
                              setState(() {
                                load = true;
                              });
                              dynamic result = await _auth.registerWithEmailAndPassword(email_id, password);
                              if(result == null){
                                setState(() {
                                  load = false;
                                  error = 'Please supply a valid email';
                                });
                              }
                            }else{
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.WARNING,
                                animType: AnimType.BOTTOMSLIDE,
                                title: 'Password not confirmed',
                                desc: 'The passwords you have entered do not match.' ,
                                btnOkOnPress: () {},
                              )..show();
                            }

                          }
                        }
                        else{
                          connectivityDialogBox();
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