/// ------------------------------------------------------------------------

/// [ContactSection]

/// ------------------------------------------------------------------------

/// Description: Build ContactSection State

/// Author(s): Sharan

/// Date Approved: 14-06-2020

/// Date Created: 21-06-2020

/// Approved By: Everyone

/// Reviewed By: Sahil

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. code - Family Code

/// Output(s): 1. ContactSection - State Widget

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 24th June, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Contacts/AddContact.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Contacts/ContactList.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

import '../Models/Contact.dart';

class ContactSection extends StatefulWidget {
  String code;
  ContactSection({Key key, @required this.code}) : super(key: key);
  @override
  _ContactSectionState createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
//    print("code: "+widget.code);
    final user_val = Provider.of<User>(context);
    int contactLength = -1;
    return StreamProvider<List<Contact>>.value(
      value: DataBaseService(famCode: widget.code).contacts,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        floatingActionButton: StreamBuilder<List<Contact>>(
            stream: DataBaseService(famCode: widget.code).contacts,
            builder: (context, snapshot) {
              int contactListLength;
              if (snapshot.hasData) {
                contactListLength = snapshot.data.length;
              } else {
                contactListLength = -1;
              }
              return FloatingActionButton(
                onPressed: () async {
                  //Check for internet connectivity
                  if (await _checkForInternetConnection()) {
                    //Checks if the max family member is reached
                    if (contactListLength == -1 || contactListLength <= 5) {
                      print("Contact List Length: " +
                          contactListLength.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddContact()),
                      );
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.INFO,
                        animType: AnimType.BOTTOMSLIDE,
                        title: 'Max Family Member Limit',
                        desc:
                            'Sorry, the max family members limits has reached...',
                        btnOkOnPress: () {},
                      )..show();
                    }
                  } else {
                    connectivityDialogBox();
                  }
                },
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
                backgroundColor: Colors.deepPurple[600],
              );
            }),
        body: Stack(
          // alignment: Alignment.center,

          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/contactList.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
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
                    onPressed: () async {
                      //Check for internet connectivity
                      if (await _checkForInternetConnection()) {
                        Navigator.pop(context);
                      } else {
                        connectivityDialogBox();
                      }
                    },
                  ),
                  Text(
                    "Family Contacts",
                    style: GoogleFonts.openSans(
                        color: Colors.deepPurpleAccent, fontSize: 30),
                  ),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.85,
              builder:
                  (BuildContext context, ScrollController scrollController) {
//                  print(widget.code);
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(193, 190, 235, 0.9),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                  ),
                  child: ContactList(
                      scrollController: scrollController, code: widget.code),
                );
              },
            ),
          ],
        ),
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
}
