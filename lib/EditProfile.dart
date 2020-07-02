import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/LoginPage.dart';
import 'package:jaldiio/Models/UserInformation.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/Services/auth.dart';
import 'package:provider/provider.dart';

import 'Models/user.dart';

class EditProfile extends StatefulWidget {

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final _customerNameController = TextEditingController(text: "");
  final _customerStatusController = TextEditingController(text: "");
  final _customerDateController = TextEditingController(text: "");
  final _customerPhoneController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {



    final user_val = Provider.of<User>(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Edit Profile",
              style: GoogleFonts.openSans(
                  color: Colors.deepPurpleAccent, fontSize: 30),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.deepPurpleAccent,
              ),
              onPressed: () {
                Navigator.pop(context);

              },
            ),
          ),
          body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    StreamBuilder<UserValue>(
                      stream: DataBaseService(uid: user_val.uid).userData,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          UserValue userValue = snapshot.data;


                          //Age calculation
                          String bday = userValue.date;
                          DateTime now = new DateTime.now();
                          List<String> dates = bday.split("/");
                          int year = int.parse(dates[2]);
                          int month = int.parse(dates[1]);
                          int day = int.parse(dates[0]);
                          int age = 0;
                          if (now.month >= month && now.day >= day) {
                            age = now.year - year;
                          } else {
                            age = now.year - year - 1;
                          }
                          String age_val = age.toString();


                          return Container(
                            padding: EdgeInsets.all(1),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,

                              border: Border.all(
                                width: 0.2,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/images/avatar_prof.png",
                                            width: 150,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(
                                                  color: Colors.deepPurpleAccent)),
                                          child: Text(
                                            "Edit",
                                            style: GoogleFonts.openSans(
                                                fontSize: 15,
                                                color: Colors.deepPurpleAccent),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2, bottom: 1),
                                          child: Text("Family Member",
                                              style: GoogleFonts.openSans(fontSize: 15)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, bottom: 1),
                                          child: Text(
                                            userValue.name+", "+ age_val,
                                            style: GoogleFonts.openSans(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, bottom: 1),
                                          child: Text(user_val.email,
                                              style: GoogleFonts.openSans(fontSize: 15)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Text(userValue.phoneNum.toString(),
                                              style: GoogleFonts.openSans(fontSize: 15)),
                                        ),
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(width: 0.5),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey.withOpacity(0.1),
                                                      spreadRadius: 1,
                                                      blurRadius: 0.5,
                                                      offset: Offset(0, 0))
                                                ],
                                                color: Colors.white),
                                            child: Text(userValue.status)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        else{
                          return Container(
                            padding: EdgeInsets.all(1),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 0.2,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/images/avatar_prof.png",
                                            width: 150,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: BorderSide(
                                                  color: Colors.deepPurpleAccent)),
                                          child: Text(
                                            "Edit",
                                            style: GoogleFonts.openSans(
                                                fontSize: 15,
                                                color: Colors.deepPurpleAccent),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2, bottom: 1),
                                          child: Text("Family Member",
                                              style: GoogleFonts.openSans(fontSize: 15)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, bottom: 1),
                                          child: Text(
                                            "Name"+", "+ "Age",
                                            style: GoogleFonts.openSans(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, bottom: 1),
                                          child: Text(user_val.email,
                                              style: GoogleFonts.openSans(fontSize: 15)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Text("Phone Number",
                                              style: GoogleFonts.openSans(fontSize: 15)),
                                        ),
                                        Container(
                                            margin: EdgeInsets.all(20),
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(width: 0.5),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                  bottomLeft: Radius.circular(10),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey.withOpacity(0.1),
                                                      spreadRadius: 1,
                                                      blurRadius: 0.5,
                                                      offset: Offset(0, 0))
                                                ],
                                                color: Colors.white),
                                            child: Text("Lets Party !")),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }

                      }
                    ),

                    Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/editprofile.png"),
                          fit: BoxFit.fill,
                          colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
                        ),
                        color: Colors.white,
                        border: Border.all(
                          width: 0.2,
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
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
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: _customerNameController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Name",
                                              hintStyle: TextStyle(color: Colors.grey),
                                            ),
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                  color: Colors.deepPurpleAccent,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (val) =>
                                            val.isEmpty ? 'Enter a name' : null,
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
                                            controller: _customerDateController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "DD/MM/YYYY",
                                              hintStyle: TextStyle(color: Colors.grey),
                                            ),
                                            style: GoogleFonts.openSans(
                                                fontSize: 18,
                                                color: Colors.deepPurpleAccent
                                            ),
                                            keyboardType: TextInputType.datetime,
                                            validator: (val) => val.length == 10
                                                ? null
                                                : "Please type a valid date",
                                            onChanged: (val) {
//                              setState(() => password = val);
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
                                            controller: _customerStatusController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Status",
                                              hintStyle: TextStyle(color: Colors.grey),
                                            ),
                                            style: GoogleFonts.openSans(
                                                fontSize: 18,
                                                color: Colors.deepPurpleAccent
                                            ),
                                            validator: (val) =>
                                            val.isEmpty
                                                ? 'Enter a Status'
                                                : null,
                                            onChanged: (val) {
//                              setState(() => password = val);
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
                                            controller: _customerPhoneController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Phone Number",
                                              hintStyle: TextStyle(color: Colors.grey),
                                            ),
                                            style: GoogleFonts.openSans(
                                                fontSize: 18,
                                                color: Colors.deepPurpleAccent
                                            ),
                                            keyboardType: TextInputType.phone,
                                            validator: (val) =>
                                            val.length < 10
                                                ? 'Enter a valid phone number'
                                                : null,
                                            onChanged: (val) {
//                              setState(() => password = val);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),


                          SizedBox(
                            height: 25,
                          ),
                          FlatButton(
                            padding: EdgeInsets.only(left: 100, right: 100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: Colors.deepPurpleAccent)),
                            child: Text(
                              "Save",
                              style: GoogleFonts.openSans(
                                  fontSize: 18, color: Colors.deepPurpleAccent),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                final FirebaseUser fireuser = await FirebaseAuth
                                    .instance.currentUser();
                                await DataBaseService(uid: fireuser.uid)
                                    .updateUserInfo(
                                    _customerNameController.text,
                                    _customerStatusController.text,
                                    _customerDateController.text,
                                    int.parse(_customerPhoneController.text),);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

        );
      }
  }

