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

class AddContact extends StatefulWidget {

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  final _NameController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "");
  final _phnoController = TextEditingController(text: "");
//  String email;
//  final _Controller = TextEditingController(text: "");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String name;
  String code;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }


  Future<void> send() async {
    final Email email = Email(
      body: "Hey " +
          _NameController.text +
          ",\n\n" +
          "Please join my family at Jaldi.io. Follow the steps below to join\n\n"+
          "1) Save the code given below\n\n"+
      "2) Enter the code in Join Family Page which appears after tapping Join Family button in the profile menu\n\n"+
      "3) Voila! you are in!\n\n\n\n" +
      "Code: "+ code,
      subject: "Invitation from: " + name ,
      recipients: [_emailController.text],
      isHTML: false,
    );
    String platformResponse = "";

    try {
      await FlutterEmailSender.send(email);
      platformResponse = "Email sent successfully";
    } catch (error) {
      platformResponse = "Something seems to be wrong..";
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }
  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {

//    FirebaseAuth.instance.currentUser().then((value) => email = value.email);
    final user_val = Provider.of<User>(context);

    return StreamBuilder<UserValue>(
      stream: DataBaseService(uid: user_val.uid).userData,
      builder: (context, snapshot) {
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Add Contact",
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
                  "Lets Connect!",
                  style: GoogleFonts.openSans(
                      color: Colors.deepPurpleAccent, fontSize: 50),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Ask your loved ones to join your family.",
                  style: GoogleFonts.openSans(
                      color: Colors.deepPurpleAccent, fontSize: 20),
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
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Family Member's email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    validator: (val) =>
                                    validateEmail(val) ? null : "Please enter an valid email",
                                    onChanged: (val) {
//                              setState(() => email_id = val);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey[100]),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _NameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Family Member's name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    validator: (val) =>
                                    val.isEmpty ? 'Please enter a valid name' : null,
                                    onChanged: (val) {
//                              setState(() => email_id = val);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[100],
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _phnoController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Family Member's phone no.",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        color: Colors.deepPurpleAccent),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    validator: (val) => val.length < 10
                                        ? 'Please enter a valid phone no.'
                                        : null,
                                    onChanged: (val) {
//                              setState(() => password = val);
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
                                        "Save",
                                        style: GoogleFonts.openSans(
                                            fontSize: 18,
                                            color: Colors.deepPurpleAccent),
                                      ),
                                      onPressed: () async{
                                        if(_formKey.currentState.validate()) {
                                          name = snapshot.data.name;
                                          code = snapshotCode.data.familyID;
                                          final FirebaseUser fireuser = await FirebaseAuth
                                              .instance.currentUser();

                                          await DataBaseService(famCode: code)
                                              .updateContactsInfo(
                                              _emailController.text,
                                              _NameController.text,
                                              int.parse(_phnoController.text));


//                                          PLEASE REMEMBER TO UNCOMMENT THIS FINALLY!
//                                          send();

                                          showInSnackBar("Invitation sent successfully.");

                                        }
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
    );
  }
}
