import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/ContactUs.dart';
import 'package:jaldiio/LoginPage.dart';
import 'package:jaldiio/ManageFamily/CreateFamily.dart';
import 'package:jaldiio/ManageFamily/DeleteFamily.dart';
import 'package:jaldiio/ManageAccount/EditProfile.dart';
import 'package:jaldiio/ManageFamily/JoinFamily.dart';
import 'package:jaldiio/Models/FamilyCodeValue.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/Services/auth.dart';
import 'package:jaldiio/Shared/GridDashboard.dart';
import 'package:jaldiio/Shared/Loading.dart';
import 'package:jaldiio/ToDos/ToDoList.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
//import 'package:multilevel_drawer/multilevel_drawer.dart';

import 'package:provider/provider.dart';

import './Animation/FadeAnimation.dart';
import 'ManageFamily/LeaveFamily.dart';
import 'Models/user.dart';
import 'Shared/MLDrawer.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<MLSubmenu> subMenuItems;
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
  
  void showSnackBar(String value, GlobalKey<ScaffoldState> key){
    key.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  //Classifies the type of member
  String typeOfMember(bool admin, bool partOfFamily){
    if(admin){
      return "Admin Family Member";
    }
    else if(partOfFamily){
      return "Family Member";
    }
    else{
      return "Member";
    }
  }


  @override
  Widget build(BuildContext context) {
    final user_val = Provider.of<User>(context);
    String name;
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
            UserValue userValue;

            //Checks if user is an admin
              bool adminValidator(){
                if(snapshot.hasData && userValue.admin)
                    return true;
                else
                    return false;
              }

            //Checks if user is part of a family
            bool partOfFamilyValidator(){
              if(snapshot.hasData && userValue.joined){
                return true;
              }
              else{
                return false;
              }
            }
            if(snapshot.hasData){
              print("data built");
              userValue = snapshot.data;


              return new MultiLevelDrawer(
                  backgroundColor: Color.fromRGBO(109, 49, 185, 0.9),
                  rippleColor: Colors.white,
                  subMenuBackgroundColor: Color.fromRGBO(253, 160, 41, 1),
                  header: Container(                  // Header for Drawer
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),
                        Image.asset("assets/images/avatar.png",width: 100,height: 100,),
                        SizedBox(height: 10,),

                        Text(userValue.name,
                           style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 25,
                          ),),
                        Text(typeOfMember(adminValidator(), partOfFamilyValidator()),
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                          ),),
                      ],
                    )),
                  ),

                  children:[           // Child Elements for Each Drawer Item
                    MLMenuItem(
                        leading: Icon(Icons.person, color: Colors.white,),
                        trailing: Icon(Icons.arrow_right, color: Colors.white),
                        content: Text(
                          "Account",
                          style: GoogleFonts.openSans(
                            color:Colors.white,
                          ),
                        ),
                        subMenuItems: [
                          MLSubmenu(onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => new EditProfile()),
                            );
                          }, submenuContent: Text("Edit Profile",
                            style: GoogleFonts.openSans(
                              color:Colors.white,
                            ),),),
                          MLSubmenu(onClick: () {}, submenuContent: Text("Delete Account",
                            style: GoogleFonts.openSans(
                              color:Colors.white,
                            ),)),
                        ],
                        onClick: () {}),


                    MLMenuItem(
                        leading: Icon(Icons.people, color: Colors.white),
                        trailing: Icon(Icons.arrow_right, color: Colors.white),
                        content: Text("Family",
                          style: GoogleFonts.openSans(
                            color:Colors.white,
                          ),),
                        onClick: () {},
                        subMenuItems: [
                          if(partOfFamilyValidator() && adminValidator()) ...[
                            MLSubmenu(onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DeleteFamily(familyCode: userValue.familyID,)),
                                  );
                                },
                             submenuContent: Text( "Delete Family",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),)),
                          ],
                          if(partOfFamilyValidator() && !adminValidator()) ...[
                            MLSubmenu(onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LeaveFamily(familyCode: userValue.familyID,)),
                              );
                            },
                                submenuContent: Text( "Leave Family",
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                  ),)),
                          ],

                          if(!partOfFamilyValidator()) ...[
                            MLSubmenu(onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CreateFamily()),
                              );
                            },
                                submenuContent: Text( "Create Family",
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                  ),)),
                            MLSubmenu(onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => JoinFamily()),
                              );
                            },
                                submenuContent: Text( "Join Family",
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                  ),)),
                          ],
                        ]),



                    MLMenuItem(
                      leading: Icon(Icons.feedback, color: Colors.white),
                      content: Text("Contact Us",
                        style: GoogleFonts.openSans(
                          color:Colors.white,
                        ),),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactUs()),
                        );
                      },
                    ),
                    MLMenuItem(
                      leading: partOfFamilyValidator() ? Icon(
                        Icons.mood,
                        color: Colors.green,
                      ): Icon(
                        Icons.mood_bad,
                        color: Colors.white,
                      ),
                      content: Text("Family Status",
                        style: GoogleFonts.openSans(
                          color:Colors.white,
                        ),),
                      onClick: () {
                        showDialog(context: context,
                        builder: (_) => partOfFamilyValidator() ?
                        OkalertDialog("Family Joined", "You belong to Rohit Family."):
                        OkalertDialog("Family not Joined", "You don't belong to any Family."));
                      },
                    ),
                  ]
              );

            }else if(snapshot.hasError){
              return new MultiLevelDrawer(
                  backgroundColor: Color.fromRGBO(109, 49, 185, 0.9),
                  rippleColor: Colors.white,
                  subMenuBackgroundColor: Color.fromRGBO(253, 160, 41, 1),
                  header: Container(                  // Header for Drawer
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),
                        Image.asset("assets/images/avatar.png",width: 100,height: 100,),
                        SizedBox(height: 10,),

                        Text("User"
                          , style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 25,
                          ),),
                        Text("Member",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                          ),),
                      ],
                    )),
                  ),

                  children:[           // Child Elements for Each Drawer Item
                    MLMenuItem(
                        leading: Icon(Icons.person, color: Colors.white,),
                        trailing: Icon(Icons.arrow_right, color: Colors.white),
                        content: Text(
                          "Account",
                          style: GoogleFonts.openSans(
                            color:Colors.white,
                          ),
                        ),
                        subMenuItems: [
                          MLSubmenu(onClick: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => new EditProfile()),
                            );
                          }, submenuContent: Text("Create Profile",
                            style: GoogleFonts.openSans(
                              color:Colors.white,
                            ),),),
                          MLSubmenu(onClick: () {}, submenuContent: Text("Delete Account",
                            style: GoogleFonts.openSans(
                              color:Colors.white,
                            ),)),
                        ],
                        onClick: () {}),


                    MLMenuItem(
                        leading: Icon(Icons.people, color: Colors.white),
                        trailing: Icon(Icons.arrow_right, color: Colors.white),
                        content: Text("Family",
                          style: GoogleFonts.openSans(
                            color:Colors.white,
                          ),),
                        onClick: () {
                          showDialog(context: context,
                            builder: (_) => OkalertDialog("Family", "Please Create a profile to access this feature."),
                            barrierDismissible: true,
                          );
                        },),

                    MLMenuItem(
                      leading: Icon(Icons.feedback, color: Colors.white),
                      content: Text("Contact Us",
                        style: GoogleFonts.openSans(
                          color:Colors.white,
                        ),),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactUs()),
                        );
                      },
                    ),
                  ]
              );
            }
            else{
              return LinearProgressIndicator();
            }
          }
        ),

//      StreamBuilder<UserValue>(
//        stream: DataBaseService(uid: user_val.uid).userData,
//        builder: (context, snapshot) {
//
//          if(snapshot.hasData){
//            UserValue userValue = snapshot.data;
//            return new Drawer(
//              child: ListView(
//                padding: EdgeInsets.zero,
//                children: <Widget>[
//                  DrawerHeader(
//                      decoration: BoxDecoration(
//                        color: Colors.deepPurpleAccent,
//                      ),
//                      child: Stack(
//                        children: <Widget>[
//                          Align(
//                            alignment: Alignment.centerLeft,
//                            child: CircleAvatar(
//                              backgroundImage: AssetImage("assets/images/avatar.png"),
//                              radius: 50,
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(right: 16),
//                            child: Align(
//                              alignment: Alignment.centerRight,
//                              child: Text(
//                                userValue.name,
//                                style: GoogleFonts.openSans(
//                                  fontSize: 23,
//                                  color: Colors.white,
//
//                                ),
//                              ),
//
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(right: 16.0),
//                            child: Align(
//                                alignment: Alignment.centerRight + Alignment(0,0.4),
//                                child: Text(
//                                    "Family Member",
//                                    style: GoogleFonts.openSans(
//                                        fontSize: 14,
//                                        color: Colors.white
//                                    )
//                                )
//                            ),
//                          )
//                        ],
//                      )),
//                  ListTile(
//                    leading: Icon(Icons.phone, size: 30, color: Colors.deepPurpleAccent,),
//                    title: Text(
//                      userValue.phoneNum.toString(),
//                      style: GoogleFonts.openSans(
//                          fontSize: 14,
//                          color: Colors.black
//                      ),
//                    ),
//                  ),
//                  Divider(
//                    color: Colors.deepPurpleAccent,
//                    thickness: 0.50,
//                  ),
//                  ListTile(
//                    leading: Icon(Icons.cake, size: 30, color: Colors.deepPurpleAccent,),
//                    title: Text(
//                      userValue.date,
//                      style: GoogleFonts.openSans(
//                          fontSize: 14,
//                          color: Colors.black
//                      ),
//                    ),
//                  ),
//                  Divider(
//                    color: Colors.deepPurpleAccent,
//                    thickness: 0.50,
//                  ),
//                  ListTile(
//                    leading: Icon(Icons.edit, size: 30, color: Colors.deepPurpleAccent,),
//                    title: Text(
//                      "Edit Profile",
//                      style: GoogleFonts.openSans(
//                          fontSize: 14,
//                          color: Colors.black
//                      ),
//                    ),
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => EditProfile()),
//                      );
//                    },
//                  ),
//                  Divider(
//                    color: Colors.deepPurpleAccent,
//                    thickness: 0.50,
//                  ),
//                  ListTile(
//                    leading: Icon(Icons.feedback, size: 30, color: Colors.deepPurpleAccent,),
//                    title: Text(
//                      "Contact Us",
//                      style: GoogleFonts.openSans(
//                          fontSize: 14,
//                          color: Colors.black
//                      ),
//                    ),
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => ContactUs()),
//                      );
//                    },
//                  ),
//                  Divider(
//                    color: Colors.deepPurple,
//                    thickness: 0.50,
//                  ),
//                  StreamBuilder<FamilyCodeValue>(
//                    stream: DataBaseService(uid: user_val.uid).codeData,
//                    builder: (context, snapshot) {
//
//                      if(snapshot.hasData && snapshot.data.familyID.isNotEmpty){
//                        return ListTile(
//                          leading: Icon(Icons.people, size: 30, color: Colors.deepPurpleAccent,),
//                          title: Text(
//                            "Joined a Family",
//                            style: GoogleFonts.openSans(
//                                fontSize: 14,
//                                color: Colors.black
//                            ),
//                          ),
//                          trailing: Icon(Icons.check_circle, color: Colors.green,),
//                        );
//                      }
//                      else{
//                        return ListTile(
//                          leading: Icon(Icons.people, size: 30, color: Colors.deepPurpleAccent,),
//                          title: Text(
//                            "Join Family",
//                            style: GoogleFonts.openSans(
//                                fontSize: 14,
//                                color: Colors.black
//                            ),
//                          ),
//                          onTap: () {
//                            Navigator.push(
//                              context,
//                              MaterialPageRoute(builder: (context) => JoinFamily()),
//                            );
////                    print("join family");
//                          },
//                        );
//                      }
//
//                    }
//                  ),
//                  Divider(
//                    color: Colors.deepPurpleAccent,
//                    thickness: 0.50,
//                  ),
//                  StreamBuilder<FamilyCodeValue>(
//                    stream: DataBaseService(uid: user_val.uid).codeData,
//                    builder: (context, snapshot) {
//
//                      if(snapshot.hasData && snapshot.data.familyID.isNotEmpty){
//                        FamilyCodeValue codeValue = snapshot.data;
////                        print(codeValue.familyID);
//                        if(codeValue.admin){
//                          return ListTile(
//                            leading: Icon(Icons.delete, size: 30, color: Colors.deepPurpleAccent,),
//                            title: Text(
//                              "Delete Family",
//                              style: GoogleFonts.openSans(
//                                  fontSize: 14,
//                                  color: Colors.black
//                              ),
//                            ),
//                            onTap: () {
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => DeleteFamily(familyCode: codeValue.familyID,)),
//                              );
//                            },
//                          );
//                        }
//                        else{
//                          return ListTile(
//                            leading: Icon(Icons.exit_to_app, size: 30, color: Colors.deepPurpleAccent,),
//                            title: Text(
//                              "Leave Family",
//                              style: GoogleFonts.openSans(
//                                  fontSize: 14,
//                                  color: Colors.black
//                              ),
//                            ),
//                            onTap: () {
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => LeaveFamily(familyCode: codeValue.familyID,)),
//                              );
//                            },
//                          );
//                        }
//
//                      }
//                      else{
//                        return ListTile(
//                          leading: Icon(Icons.group_add, size: 30, color: Colors.deepPurpleAccent,),
//                          title: Text(
//                            "Create Family",
//                            style: GoogleFonts.openSans(
//                                fontSize: 14,
//                                color: Colors.black
//                            ),
//                          ),
//                          onTap: () {
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(builder: (context) => CreateFamily()),
//                              );
//
////                    print("join family");
//                          },
//                        );
//                      }
//
//                    }
//                  ),
//                ],
//              ),
//            );
//          }else{
//            return new Drawer(
//              child: ListView(
//                padding: EdgeInsets.zero,
//                children: <Widget>[
//                  DrawerHeader(
//                      decoration: BoxDecoration(
//                        color: Colors.deepPurpleAccent,
//                      ),
//                      child: Stack(
//                        children: <Widget>[
//                          Align(
//                            alignment: Alignment.centerLeft,
//                            child: CircleAvatar(
//                              backgroundImage: AssetImage("assets/images/avatar.png"),
//                              radius: 50,
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(right: 16),
//                            child: Align(
//                              alignment: Alignment.centerRight,
//                              child: Text(
//                                "Jaldi.io User",
//                                style: GoogleFonts.openSans(
//                                  fontSize: 23,
//                                  color: Colors.white,
//
//                                ),
//                              ),
//
//                            ),
//                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(right: 16.0),
//                            child: Align(
//                                alignment: Alignment.centerRight + Alignment(0,0.4),
//                                child: Text(
//                                    "Family Member",
//                                    style: GoogleFonts.openSans(
//                                        fontSize: 14,
//                                        color: Colors.white
//                                    )
//                                )
//                            ),
//                          )
//                        ],
//                      )),
//                  ListTile(
//                    leading: Icon(Icons.phone, size: 30, color: Colors.deepPurpleAccent,),
//                    title: Text(
//                      "Phone Number",
//                      style: GoogleFonts.openSans(
//                          fontSize: 14,
//                          color: Colors.black
//                      ),
//                    ),
//                  ),
//                  Divider(
//                    color: Colors.deepPurpleAccent,
//                    thickness: 0.50,
//                  ),
//                  ListTile(
//                    leading: Icon(Icons.cake, size: 30, color: Colors.deepPurpleAccent,),
//                    title: Text(
//                      "My Big Day",
//                      style: GoogleFonts.openSans(
//                          fontSize: 14,
//                          color: Colors.black
//                      ),
//                    ),
//                  ),
//                  Divider(
//                    color: Colors.deepPurpleAccent,
//                    thickness: 0.50,
//                  ),
//                  ListTile(
//                    leading: Icon(Icons.edit, size: 30, color: Colors.deepPurpleAccent,),
//                    title: Text(
//                      "Edit Profile",
//                      style: GoogleFonts.openSans(
//                          fontSize: 14,
//                          color: Colors.black
//                      ),
//                    ),
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => EditProfile()),
//                      );
//                    },
//                  ),
//                  Divider(
//                    color: Colors.deepPurpleAccent,
//                    thickness: 0.50,
//                  ),
//                  ListTile(
//                    leading: Icon(Icons.feedback, size: 30, color: Colors.deepPurpleAccent,),
//                    title: Text(
//                      "Contact Us",
//                      style: GoogleFonts.openSans(
//                          fontSize: 14,
//                          color: Colors.black
//                      ),
//                    ),
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => ContactUs()),
//                      );
//                    },
//                  ),
//                  Divider(
//                    color: Colors.deepPurple,
//                    thickness: 0.50,
//                  ),
//                ],
//              ),
//            );
//          }
//
//        }
//      ),
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
                          stream: DataBaseService(uid:user_val.uid).userData,
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              UserValue userValue = snapshot.data;
                              name = userValue.name;
                              return Text(userValue.name+"'s Family",
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)));
                            }
                            else{
                              name = "";
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

            GridDashboard(name: name,scaffoldKey: _scaffoldKey,),

          ],
        ),
      ),
    );
  }

  Widget OkalertDialog(String title, String content){
    return AlertDialog(
      title: Text(title,
      style: GoogleFonts.openSans(
        color: Colors.white,
      ),),
      content: Text(content,
      style: GoogleFonts.openSans(
        color: Colors.white,
      ),),
      actions: [
        FlatButton(
            child: Text("Okay",
            style: GoogleFonts.openSans(
              color: Colors.amber,
            ),),
            onPressed: () {
              Navigator.pop(context);
            },
        ),
      ],
      elevation: 24.0,
      backgroundColor: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }

  Widget deleteAccountDialog(){
    return AlertDialog(
      title: Text("Delete account",
        style: GoogleFonts.openSans(
          color: Colors.white,
        ),),
      content: Text("We are sorry to see you leave.\n Are you sure you wish to say goodbye to us?",
        style: GoogleFonts.openSans(
          color: Colors.white,
        ),),
      actions: [
        FlatButton(
          child: Text("Yes ",
            style: GoogleFonts.openSans(
              color: Colors.amber,
            ),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      elevation: 24.0,
      backgroundColor: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
    );
  }
}
