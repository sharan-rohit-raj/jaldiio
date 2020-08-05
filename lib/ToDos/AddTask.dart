import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Models/FamilyCodeValue.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _textController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  String code;
  @override
  Widget build(BuildContext context) {

    final user_val = Provider.of<User>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
                      } else  {connectivityDialogBox(context);}
                    },
                  ),
                  Text(
                    "Add Task",
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
              "Lets get some work done!",
              style: GoogleFonts.openSans(
                  color: Colors.deepPurpleAccent, fontSize: 50),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Collaborate with your family to accomplish family tasks.",
                style: GoogleFonts.openSans(
                    color: Colors.deepPurpleAccent, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 0.5,
                      offset: Offset(0, 0))
                ],
              ),
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
                                  bottom: BorderSide(color: Colors.grey[100]),
                                ),
                              ),
                              child: TextFormField(
                                controller: _textController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Title of the task",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                                validator: (val) =>
                                 val.isEmpty ? "Please enter a title" : null,
                                onChanged: (val) {
//                              setState(() => email_id = val);
                                },
                              ),
                            ),
                            SizedBox(height: 90),
                            StreamBuilder<FamilyCodeValue>(
                                stream: DataBaseService(uid: user_val.uid).codeData,
                                builder: (context, snapshotCode) {
                                  return FlatButton(
                                    padding: EdgeInsets.only(left: 100, right: 100),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                            color: Colors.deepPurpleAccent)),
                                    child: Text(
                                      "Add",
                                      style: GoogleFonts.openSans(
                                          fontSize: 18,
                                          color: Colors.deepPurpleAccent),
                                    ),
                                    onPressed: () async{
                                      if(await _checkForInternetConnection()){
                                        if(_formKey.currentState.validate()) {
                                          code = snapshotCode.data.familyID;
                                          final FirebaseUser fireuser = await FirebaseAuth
                                              .instance.currentUser();

                                          await DataBaseService(famCode: code)
                                              .updateTasks(
                                              _textController.text,
                                              false);

                                          Navigator.pop(context);

                                        }
                                      } else  {connectivityDialogBox(context);}

                                    },
                                  );
                                }
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
    );
  }
}

//Connectivity Error Dialog Box
AwesomeDialog connectivityDialogBox(BuildContext context){
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.WARNING,
    animType: AnimType.BOTTOMSLIDE,
    title: 'Connectivity Error',
    desc: 'Hmm..looks like there is no connectivity...',
    btnOkOnPress: () {},
  )..show();
}
