/// ------------------------------------------------------------------------
/// CreateFamily.dart
/// ------------------------------------------------------------------------
/// Description: Class to help user create family.
/// Author(s): Sharan
/// Date Approved: 7/07/2020
/// Date Created: 5/07/2020
/// Approved By: Bhavya
/// Reviewed By: Kaish
/// ------------------------------------------------------------------------
/// File(s) Accessed: null
/// File(s) Modified: null
/// ------------------------------------------------------------------------
/// Input(s):
/// Output(s): Sends a signal to Database Service class to initialise the
/// document field for the family, make the current user admin and part of
/// a family.
/// ------------------------------------------------------------------------
/// Error-Handling(s): Checks if family name is already taken or not and checks
/// for internet connectivity.
/// ------------------------------------------------------------------------
/// Modification(s): 1. Internet Connectivity check added - 26th July, 2020
/// ------------------------------------------------------------------------
/// Fault(s): None
/// ------------------------------------------------------------------------
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:provider/provider.dart';
import '../Services/DataBaseService.dart';

class CreateFamily extends StatefulWidget {
  @override
  _CreateFamilyState createState() => _CreateFamilyState();
}

class _CreateFamilyState extends State<CreateFamily> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController(text: "");
  final codeStored = SnackBar(
      content: Center(
          child: Text(
    'Yay! your family code has been created!',
    textAlign: TextAlign.center,
  )));
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  //Check for Internet connectivity
  Future _checkForInternetConnection() async {
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
    final user_val = Provider.of<User>(context);
    bool isAlreadyPressed = false;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/createFamily.png"),
                colorFilter: new ColorFilter.mode(
                    Colors.white.withOpacity(0.3), BlendMode.dstATop),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.deepPurpleAccent,
                        ),
                        onPressed: () async{
                          if(await _checkForInternetConnection()){
                            Navigator.pop(context);
                          }else{
                            connectivityDialogBox();
                          }

                        },
                      ),
                      Text(
                        "Create Family",
                        style: GoogleFonts.openSans(
                            color: Colors.deepPurpleAccent, fontSize: 30),
                      ),
                      SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "The fun begins here!",
                  style: GoogleFonts.openSans(
                      color: Colors.deepPurpleAccent, fontSize: 50),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    "Create a unique family code to begin adding your loved ones to your family.",
                    style: GoogleFonts.openSans(
                        color: Colors.deepPurpleAccent, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: FadeAnimation(
                          1,
                          Container(
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
                                      bottom:
                                          BorderSide(color: Colors.grey[100]),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _codeController,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.deepPurpleAccent,
                                              width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.deepPurpleAccent,
                                              width: 0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Unique Family Code",
                                      hintStyle: TextStyle(
                                          color: Colors.deepPurple[200],
                                          fontWeight: FontWeight.w100),
                                    ),
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    obscureText: true,
                                    validator: (val) => val.isEmpty
                                        ? "Please enter a valid code"
                                        : null,
                                    onChanged: (val) {
//                              setState(() => email_id = val);
                                    },
                                  ),
                                ),
                                SizedBox(height: 30),
                                FlatButton(
                                  padding:
                                      EdgeInsets.only(left: 100, right: 100),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Colors.deepPurpleAccent)),
                                  child: Text(
                                    "Create",
                                    style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        color: Colors.deepPurpleAccent),
                                  ),
                                  onPressed: !isAlreadyPressed
                                      ? () async {
                                          if (await _checkForInternetConnection()) {
                                            setState(() {
                                              isAlreadyPressed = true;
                                            });
                                            if (_formKey.currentState
                                                .validate()) {
                                              final QuerySnapshot result =
                                              await Firestore.instance
                                                  .collection('family_info')
                                                  .getDocuments();
                                              final List<DocumentSnapshot>
                                              documents = result.documents;
                                              bool found = false;
                                              int index = 0;
                                              print(documents.length);
                                              while (index < documents.length &&
                                                  found == false) {
//                                    print(documents[index].documentID);
                                                if (documents[index]
                                                    .documentID
                                                    .compareTo(
                                                    _codeController
                                                        .text) ==
                                                    0) {
                                                  found = true;
                                                }
                                                index++;
                                              }

                                              if (found == false) {
                                                await DataBaseService(
                                                    famCode: _codeController
                                                        .text)
                                                    .initializeDocField();
                                                await DataBaseService(
                                                    famCode: _codeController
                                                        .text)
                                                    .initializeImageTagField();
                                                await DataBaseService(
                                                    famCode: _codeController
                                                        .text)
                                                    .initializeRecipeTagField();
                                                final FirebaseUser fireuser =
                                                await FirebaseAuth.instance
                                                    .currentUser();
                                                await DataBaseService(
                                                    uid: fireuser.uid)
                                                    .updateFamilyCode(
                                                    _codeController.text);
                                                await DataBaseService(
                                                    uid: fireuser.uid)
                                                    .updateAdmin(true);
                                                await DataBaseService(
                                                    uid: fireuser.uid)
                                                    .updateJoined(true);
                                                showInSnackBar(
                                                    "Yay! your family name was stored successfully!");
                                              } else {
                                                showInSnackBar(
                                                    "We are sorry, that code was already taken by another family. Please try again.");
                                              }
                                            }
                                          } else {
                                              connectivityDialogBox();
                                            }
                                        }
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Connectivity Error Dialog Box
  AwesomeDialog connectivityDialogBox() {
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
