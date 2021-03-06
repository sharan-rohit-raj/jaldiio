/// ------------------------------------------------------------------------
/// ContactUs.dart
/// ------------------------------------------------------------------------
/// Description: Class to help user leave a family.
/// Author(s): Sharan
/// Date Approved: 25/07/2020
/// Date Created: 20/07/2020
/// Approved By: Ravish
/// Reviewed By: Sharan
/// ------------------------------------------------------------------------
/// File(s) Accessed: null
/// File(s) Modified: null
/// ------------------------------------------------------------------------
/// Input(s):
/// Output(s): Opens a email with user typed enough.
/// ------------------------------------------------------------------------
/// Error-Handling(s): Makes sure inputs are not left empty. Internet connectivity.
/// ------------------------------------------------------------------------
/// Modification(s): 1. Internet Connectivity check added - 26th July, 2020
/// ------------------------------------------------------------------------
/// Fault(s): None
/// ------------------------------------------------------------------------
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _customerNameController = TextEditingController(text: "");
  final _customerMessageController = TextEditingController(text: "");
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Future<void> send() async {
    final Email email = Email(
      body: "Customer " +
          _customerNameController.text +
          " says,\n\n" +
          _customerMessageController.text,
      subject: "Feedback from: " + _customerNameController.text,
      recipients: ["srrnatar@gmail.com"],
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

  //Check for Internet connection
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
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/contactList.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
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
                        "Contact Us",
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
                  "Get in touch!",
                  style: GoogleFonts.openSans(
                      color: Colors.deepPurpleAccent, fontSize: 50),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Tell us how we are doing \nconnecting your family.",
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
                    image: DecorationImage(
                      image: AssetImage("assets/images/contactus.png"),
                      fit: BoxFit.fill,
                      colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.dstATop),
                    ),
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
                                    controller: _customerNameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Your name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.deepPurpleAccent,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    validator: (val) =>
                                    val.isEmpty ? 'Please enter a name' : null,
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
                                    controller: _customerMessageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Your message",
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        color: Colors.deepPurpleAccent),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    validator: (val) => val.isEmpty
                                        ? 'Please enter a message.'
                                        : null,
                                    onChanged: (val) {
//                              setState(() => password = val);
                                    },
                                  ),
                                ),
                                SizedBox(height: 150),
                                FlatButton(
                                  padding: EdgeInsets.only(left: 100, right: 100),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                          color: Colors.deepPurpleAccent)),
                                  child: Text(
                                    "Send",
                                    style: GoogleFonts.openSans(
                                        fontSize: 18,
                                        color: Colors.deepPurpleAccent),
                                  ),
                                  onPressed: () async{
                                    if(await _checkForInternetConnection()){
                                      if(_formKey.currentState.validate())
                                        send();
                                    }else{
                                    connectivityDialogBox();
                                    }

                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "We'll get back to you soon.",
                                    style: GoogleFonts.openSans(
                                        color: Colors.deepPurpleAccent,
                                        fontSize: 12),
                                  ),
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
