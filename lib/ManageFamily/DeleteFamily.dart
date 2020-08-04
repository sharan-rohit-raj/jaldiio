import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/ManageFamily/DeleteMembers/CancelButton.dart';
import 'package:jaldiio/ManageFamily/DeleteMembers/DeleteFamilyMembers.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:provider/provider.dart';

import '../Services/DataBaseService.dart';

class DeleteFamily extends StatefulWidget {
  String familyCode;
  DeleteFamily({Key key, @required this.familyCode}) : super(key: key);

  @override
  _DeleteFamilyState createState() => _DeleteFamilyState();
}

class _DeleteFamilyState extends State<DeleteFamily> {

  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController(text: "");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  bool same = false;
  bool checkIfSame(){
    if(_codeController.text.compareTo(widget.familyCode)==0){
      same = true;
    }
    else{
      same = false;
    }
    return same;
  }

  @override
  Widget build(BuildContext context) {
    print("family code: "+widget.familyCode);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(

        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/deleteFamily.png"),
                colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.dstATop),
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        "Delete Family",
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
                  "Hope you create a new family soon!",
                  style: GoogleFonts.openSans(
                      color: Colors.deepPurpleAccent, fontSize: 50),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    "Please enter your family code below to delete family.",
                    style: GoogleFonts.openSans(
                        color: Colors.deepPurpleAccent, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    shape: BoxShape.rectangle,
//                    border: Border.all(
//                      color: Colors.deepPurpleAccent,
//                      width: 0.5
//                    ),
//                    borderRadius: BorderRadius.all(Radius.circular(15)),
//
//                    boxShadow: [
//                      BoxShadow(
//                          color: Colors.grey.withOpacity(0.1),
//                          spreadRadius: 3,
//                          blurRadius: 0.5,
//                          offset: Offset(0, 0))
//                    ],
//                  ),
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
                                  child: TextFormField(
                                    controller: _codeController,
                                    decoration: InputDecoration(

//                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.white,
                                      hintText: "Paste the family code here",
                                      hintStyle: TextStyle(color: Colors.deepPurple[200], fontWeight: FontWeight.w100),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 0.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)
                                          )
                                      ),
                                    ),
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    obscureText: true,
                                    validator: (val) =>
                                    val.isEmpty ?  "Please enter a valid code" : null,
                                    onChanged: (val) {
                                      setState(() {
                                        same = checkIfSame();
                                      });
                                    },
                                  ),
                                ),


                                SizedBox(height: 30),
                                StreamProvider<List<Contact>>.value(
                                  value: DataBaseService(famCode: widget.familyCode).contacts,
                                  child: same ? DeleteFamilMembers(codeController: _codeController.text, scaffoldKey: _scaffoldKey, familyCode: widget.familyCode,formKey: _formKey,)
                                  : CancelButton(deletecontext: context,),
                                ),
//                                FlatButton(
//                                  padding: EdgeInsets.only(left: 100, right: 100),
//                                  color: Colors.deepPurpleAccent,
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(15),
//                                      side: BorderSide(
//                                          color: Colors.deepPurpleAccent)),
//                                  child: Text(
//                                    "Cancel",
//                                    style: GoogleFonts.openSans(
//                                        fontSize: 18,
//                                        color: Colors.white),
//                                  ),
//                                  onPressed: () async{
////                                    Navigator.pop(context);
//                                  print(_codeController.text);
//                                  },
//                                ),
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
}
