import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
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
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                side: BorderSide(color: Colors.deepPurpleAccent)),
                            child: Text(
                              "Edit",
                              style: GoogleFonts.openSans(
                                  fontSize: 15, color: Colors.deepPurpleAccent),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 1),
                            child: Text("Family Member",
                                style: GoogleFonts.openSans(fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 1),
                            child: Text(
                              "Sharan, 22",
                              style: GoogleFonts.openSans(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 1),
                            child: Text("jaldi_io@gmail.com",
                                style: GoogleFonts.openSans(fontSize: 15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text("+3657774973",
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
            ),
            
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(10),
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
                  Form(
//                  key: _formKey,
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Age",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    color: Colors.black
                                ),
                                keyboardType: TextInputType.number,
                                validator: (val) => (int.parse(val) >= 0 && int.parse(val) <=100)
                                    ? null
                                    : "Please type a valid age",
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Status",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  color: Colors.black
                                ),
                                validator: (val) => val.isEmpty
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
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Phone Number",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                style: GoogleFonts.openSans(
                                  fontSize: 18,
                                  color: Colors.black
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (val) => val.length < 7
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.deepPurpleAccent)),
                    child: Text(
                      "Save",
                      style: GoogleFonts.openSans(
                          fontSize: 18, color: Colors.deepPurpleAccent),
                    ),
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
