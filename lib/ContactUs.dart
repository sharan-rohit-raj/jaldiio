import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      icon: Icon(Icons.arrow_back_ios, color: Colors.deepPurpleAccent,),
                      onPressed: () {
                        Navigator.pop(context);
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
                                    hintText: "Your name",
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
                                    hintText: "Your email",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      color: Colors.black
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) => val.isEmpty
                                      ? "Please enter an email"
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
                                    hintText: "Your message",
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      color: Colors.black
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  validator: (val) => val.length < 7
                                      ? 'Enter a valid phone number'
                                      : null,
                                  onChanged: (val) {
//                              setState(() => password = val);
                                  },
                                ),
                              ),

                              SizedBox(
                                height: 150
                              ),
                              FlatButton(
                                padding: EdgeInsets.only(left: 100, right: 100),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(color: Colors.deepPurpleAccent)),
                                child: Text(
                                  "Send Message",
                                  style: GoogleFonts.openSans(
                                      fontSize: 18, color: Colors.deepPurpleAccent),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "We'll get back to you soon.",
                                  style: GoogleFonts.openSans(
                                      color: Colors.deepPurpleAccent, fontSize: 12),
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
      ),
      );
  }
}
