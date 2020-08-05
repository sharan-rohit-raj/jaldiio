import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Models/FamilyCodeValue.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Shared/Loading.dart';
import 'package:provider/provider.dart';
import '../Services/DataBaseService.dart';

class LeaveFamily extends StatefulWidget {
  String familyCode;
  LeaveFamily({Key key, @required this.familyCode}) : super(key: key);

  @override
  _LeaveFamilyState createState() => _LeaveFamilyState();
}

class _LeaveFamilyState extends State<LeaveFamily> {

  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController(text: "");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  //Check for internet connection
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
    final user_val = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(

        children: <Widget>[
          Container(
          decoration: BoxDecoration(
              image: DecorationImage(

              image: AssetImage("assets/images/leaveFamily.png"),
          colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop),
          fit: BoxFit.contain,
        ),
        ),),
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
                        "Leave Family",
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
                  height: 50,
                ),
                Text(
                  "Sorry it didn't work out for you...",
                  style: GoogleFonts.openSans(
                      color: Colors.deepPurpleAccent, fontSize: 50),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    "Are you sure that you wish to leave?",
                    style: GoogleFonts.openSans(
                        color: Colors.deepPurpleAccent, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                StreamBuilder<FamilyCodeValue>(
                    stream: DataBaseService(uid: user_val.uid).codeData,
                    builder: (context, snapshot) {

                      return StreamBuilder<UserValue>(
                          stream: DataBaseService(uid: user_val.uid).userData,
                          builder: (context, snapshotUser) {
                            if(snapshotUser.hasData){
                              String name_id = user_val.email;
                              return FlatButton(
                                padding: EdgeInsets.only(left: 100, right: 100),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(
                                        color: Colors.deepPurpleAccent)),
                                child: Text(
                                  "Leave",
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      color: Colors.deepPurpleAccent),
                                ),
                                onPressed: () async{

                                  if(await _checkForInternetConnection()){
                                    final FirebaseUser fireuser =
                                    await FirebaseAuth.instance.currentUser();
                                    await DataBaseService(uid: fireuser.uid)
                                        .leaveFamily();
                                    await DataBaseService(famCode: snapshot.data.familyID, uid: fireuser.uid).removeMember(name_id);
                                    await DataBaseService(uid: fireuser.uid).updateJoined(false);
                                    await DataBaseService(famCode: snapshot.data.familyID)
                                        .deleteContactDoc(name_id);
                                    await DataBaseService(uid: fireuser.uid).leaveFamily();
                                    showInSnackBar("Left family successfully.");
                                  }else{
                                    connectivityDialogBox();
                                  }
                                },
                              );
                            }
                            else{
                              return Loading();
                            }

                          }
                      );
                    }
                ),
                SizedBox(
                  height: 15,
                ),
                FlatButton(
                  padding: EdgeInsets.only(left: 100, right: 100),
                  color: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                          color: Colors.deepPurpleAccent)),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.openSans(
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
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
