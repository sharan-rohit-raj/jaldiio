import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/ContactUs.dart';
import 'package:jaldiio/EditProfile.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/Services/auth.dart';
import 'package:jaldiio/Shared/GridDashboard.dart';
import 'package:jaldiio/ToDoList.dart';
import 'package:provider/provider.dart';

import './Animation/FadeAnimation.dart';
import 'Models/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _current = 0;

  List images = [
    "https://images.unsplash.com/photo-1522426266214-ec2d2abb9ce0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1353&q=80",
    "https://images.unsplash.com/photo-1591238008815-d9a603f0db4f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=717&q=80",
    "https://images.unsplash.com/photo-1591227532336-85280d0cf355?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final user_val = Provider.of<User>(context);
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(83, 0, 181, 1.0),
        elevation: 0.0,
        leading: new IconButton(
          icon: new Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      drawer: StreamBuilder<UserValue>(
        stream: DataBaseService(uid: user_val.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData){
            UserValue userValue = snapshot.data;
            return new Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/images/avatar.png"),
                              radius: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                userValue.name,
                                style: GoogleFonts.openSans(
                                  fontSize: 23,
                                  color: Colors.white,

                                ),
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Align(
                                alignment: Alignment.centerRight + Alignment(0,0.4),
                                child: Text(
                                    "Family Member",
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: Colors.white
                                    )
                                )
                            ),
                          )
                        ],
                      )),
                  ListTile(
                    leading: Icon(Icons.phone, size: 30, color: Colors.deepPurpleAccent,),
                    title: Text(
                      userValue.phoneNum.toString(),
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.deepPurpleAccent,
                    thickness: 0.50,
                  ),
                  ListTile(
                    leading: Icon(Icons.cake, size: 30, color: Colors.deepPurpleAccent,),
                    title: Text(
                      userValue.date,
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.deepPurpleAccent,
                    thickness: 0.50,
                  ),
                  ListTile(
                    leading: Icon(Icons.edit, size: 30, color: Colors.deepPurpleAccent,),
                    title: Text(
                      "Edit Profile",
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.deepPurpleAccent,
                    thickness: 0.50,
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback, size: 30, color: Colors.deepPurpleAccent,),
                    title: Text(
                      "Contact Us",
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactUs()),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.deepPurple,
                    thickness: 0.50,
                  ),
                ],
              ),
            );
          }else{
            return new Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/images/avatar.png"),
                              radius: 50,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Jaldi.io User",
                                style: GoogleFonts.openSans(
                                  fontSize: 23,
                                  color: Colors.white,

                                ),
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Align(
                                alignment: Alignment.centerRight + Alignment(0,0.4),
                                child: Text(
                                    "Family Member",
                                    style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        color: Colors.white
                                    )
                                )
                            ),
                          )
                        ],
                      )),
                  ListTile(
                    leading: Icon(Icons.phone, size: 30, color: Colors.deepPurpleAccent,),
                    title: Text(
                      "Phone Number",
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.deepPurpleAccent,
                    thickness: 0.50,
                  ),
                  ListTile(
                    leading: Icon(Icons.cake, size: 30, color: Colors.deepPurpleAccent,),
                    title: Text(
                      "My Big Day",
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.deepPurpleAccent,
                    thickness: 0.50,
                  ),
                  ListTile(
                    leading: Icon(Icons.edit, size: 30, color: Colors.deepPurpleAccent,),
                    title: Text(
                      "Edit Profile",
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.deepPurpleAccent,
                    thickness: 0.50,
                  ),
                  ListTile(
                    leading: Icon(Icons.feedback, size: 30, color: Colors.deepPurpleAccent,),
                    title: Text(
                      "Contact Us",
                      style: GoogleFonts.openSans(
                          fontSize: 14,
                          color: Colors.black
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ContactUs()),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.deepPurple,
                    thickness: 0.50,
                  ),
                ],
              ),
            );
          }

        }
      ),
      backgroundColor: Color(0xff392850),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color.fromRGBO(26, 6, 62, 1.0),
              Color.fromRGBO(51, 0, 111, 1.0),
              Color.fromRGBO(83, 0, 181, 1.0)
            ])),
        child: Column(
          children: <Widget>[
//            CarouselSlider(
//              height: 400.0,
//              initialPage: 0,
//              enlargeCenterPage: true,
//              autoPlay: true,
//              reverse: false,
//              enableInfiniteScroll: true,
//              autoPlayInterval: Duration(seconds: 2),
//              autoPlayAnimationDuration: Duration(milliseconds: 2000),
//              pauseAutoPlayOnTouch: Duration(seconds: 10),
//              scrollDirection: Axis.horizontal,
//              onPageChanged: (index) {
//                setState(() {
//                  _current = index;
//                });
//              },
//              items: images.map((imgUrl) {
//                  return Builder(
//                    builder: (BuildContext context){
//                      return Container(
//                        width: MediaQuery.of(context).size.width,
//                        margin: EdgeInsets.symmetric(horizontal: 10.0),
//                        decoration: BoxDecoration(
//                          color: Colors.green,
//                        ),
//                          child: Image.network(
//                            imgUrl,
//                            fit: BoxFit.fill,
//                            ),
//                        );
//                    },
//                  );
//              }).toList(),
//            ),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
              child: FadeAnimation(
                1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 230,
                      width: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image: AssetImage("assets/images/logo.png")),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),

            //Setting the padding for the word "Jhony's Family"
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: FadeAnimation(
                1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder<UserValue>(
                          stream: DataBaseService(uid: user_val.uid).userData,
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              UserValue userValue = snapshot.data;
                              return Text(userValue.name+"'s Family",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)));
                            }
                            else{
                              return Text("Jaldi.io's Family",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)));
                            }

                          }
                        ),
                        SizedBox(height: 4),
                        Text("Home",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Color(0xffa29aac),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),
                    IconButton(
                        alignment: Alignment.topCenter,
                        icon: Icon(
                          Icons.message,
                          color: Colors.white,
                          size: 30,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GridDashboard(),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: map<Widget>(
//                images, (index, url){
//                  return Container(
//                    width: 10.0,
//                    height: 10.0,
//                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal:20),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: _current == index ? Colors.redAccent : Colors.green,
//                    ),
//                  );
//                }
//              ),
//
//
//            ),

//            SizedBox(
//              height: 20,
//              ),
//
//              RaisedButton(
//                color: Colors.purple[100],
//                child: Text(
//                  "To-Do List"
//
//                  ),
//                onPressed: (){
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => ToDoList()),
//                    );
//              },)
          ],
        ),
      ),
    );
  }
}
