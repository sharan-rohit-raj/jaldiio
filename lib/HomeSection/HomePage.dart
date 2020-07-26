import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Contacts/ContactSection.dart';
import 'package:jaldiio/HomeSection/CustomIcons.dart';
import 'package:jaldiio/ImagesSection/CarouselSection.dart';
import 'package:jaldiio/ImagesSection/ImageSection.dart';
import 'package:jaldiio/ManageFamily/CreateFamily.dart';
import 'package:jaldiio/ManageFamily/DeleteFamily.dart';
import 'package:jaldiio/ManageFamily/JoinFamily.dart';
import 'package:jaldiio/ManageFamily/LeaveFamily.dart';
import 'package:jaldiio/Models/FamilyCodeValue.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/RecipesZone/RecipeZone.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/Services/auth.dart';
import 'package:jaldiio/Shared/Loading.dart';
import 'package:jaldiio/Shared/MLDrawer.dart';
import 'package:jaldiio/ToDos/ToDoList.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'CardScroll.dart';
import 'Data.dart';
import '../ContactUs.dart';
import '../ManageAccount/EditProfile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  final PageController controller = PageController(viewportFraction: 0.8);
//  var currentIndex = images.length - 1.0;
  int currentIndex = 0;
  int bgcolor;
  int interiorColor;
  Color offsetColor;
  bool toggleDayNight;

  void showSnackBar(String value, GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  //Classifies the type of member
  String typeOfMember(bool admin, bool partOfFamily) {
    if (admin) {
      return "Admin Family Member";
    } else if (partOfFamily) {
      return "Family Member";
    } else {
      return "Member";
    }
  }

  void nightMode() {
    bgcolor = 0xFF240E45;
    interiorColor = 0xFFFFFFFF;
    offsetColor = Colors.amber;
  }

  void dayMode() {
    bgcolor = 0xFFCCBEDE;
    interiorColor = 0xFF5B3298;
    offsetColor = Colors.black87;
  }

  void setMode(bool switchMode) {
    if (switchMode) {
      nightMode();
    } else {
      dayMode();
    }
  }

  String salutations() {
    var now = DateTime.now();
    String salutation;
    if (now.hour >= 6 && now.hour < 10) {
      dayMode();
      salutation = "Rise and Shine";
      toggleDayNight = false;
    } else if (now.hour >= 10 && now.hour < 12) {
      dayMode();
      salutation = "Good Morning";
      toggleDayNight = false;
    } else if (now.hour >= 12 && now.hour < 17) {
      dayMode();
      salutation = "Good Afternoon";
      toggleDayNight = false;
    } else if (now.hour >= 17 && now.hour < 22) {
      nightMode();
      salutation = " Good Evening";
      toggleDayNight = true;
    } else {
      nightMode();
//    dayMode();
      salutation = "Sleep Tight";
      toggleDayNight = true;
    }

    return salutation;
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    Timer(Duration(milliseconds: 200), () => _animationController.forward());
    controller.addListener(() {
      int next = controller.page.round();
      if (currentIndex != next) {
        setState(() {
          currentIndex = next;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    controller.addListener(() {
//      setState(() {
//        currentIndex = controller.page;
//      });
//    });

    setState(() {
      salutations();
    });
    final user_val = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Color(bgcolor),
      key: _scaffoldKey,
      drawer: StreamBuilder<UserValue>(
          stream: DataBaseService(uid: user_val.uid).userData,
          builder: (context, snapshot) {
            UserValue userValue;

            //Checks if user is an admin
            bool adminValidator() {
              if (snapshot.hasData && userValue.admin)
                return true;
              else
                return false;
            }

            //Checks if user is part of a family
            bool partOfFamilyValidator() {
              if (snapshot.hasData && userValue.joined) {
                return true;
              } else {
                return false;
              }
            }

            if (snapshot.hasData) {
//              print("data built");
              userValue = snapshot.data;

              return StreamBuilder<FamilyCodeValue>(
                  stream: DataBaseService(uid: user_val.uid).codeData,
                  builder: (context, snapshotCode) {
                    FamilyCodeValue familyCodeValue = null;
                    if (snapshotCode.hasData) {
                      familyCodeValue = snapshotCode.data;
                    } else {
                      return Loading();
                    }
                    return new MultiLevelDrawer(
                        backgroundColor: Color.fromRGBO(109, 49, 185, 0.9),
                        rippleColor: Colors.white,
                        subMenuBackgroundColor: Color.fromRGBO(253, 160, 41, 1),
                        header: Container(
                          // Header for Drawer
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 70,
                              ),
                              Image.asset(
                                "assets/images/avatar.png",
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                userValue.name,
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                typeOfMember(
                                    adminValidator(), partOfFamilyValidator()),
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                        ),
                        children: [
                          // Child Elements for Each Drawer Item
                          MLMenuItem(
                              leading: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              trailing:
                                  Icon(Icons.arrow_right, color: Colors.white),
                              content: Text(
                                "Account",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                ),
                              ),
                              subMenuItems: [
                                MLSubmenu(
                                  onClick: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new EditProfile()),
                                    );
                                  },
                                  submenuContent: Text(
                                    "Edit Profile",
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                MLSubmenu(
                                    onClick: () {},
                                    submenuContent: Text(
                                      "Delete Account",
                                      style: GoogleFonts.openSans(
                                        color: Colors.white,
                                      ),
                                    )),
                              ],
                              onClick: () {}),

                          MLMenuItem(
                              leading: Icon(Icons.people, color: Colors.white),
                              trailing:
                                  Icon(Icons.arrow_right, color: Colors.white),
                              content: Text(
                                "Family",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                ),
                              ),
                              onClick: () {},
                              subMenuItems: [
                                if (partOfFamilyValidator() &&
                                    familyCodeValue != null) ...[
                                  MLSubmenu(
                                      onClick: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ContactSection(
                                                    code: familyCodeValue
                                                        .familyID,
                                                  )),
                                        );
                                      },
                                      submenuContent: Text(
                                        "Add/View Family",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                                if (partOfFamilyValidator() &&
                                    adminValidator()) ...[
                                  MLSubmenu(
                                      onClick: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DeleteFamily(
                                                    familyCode:
                                                        userValue.familyID,
                                                  )),
                                        );
                                      },
                                      submenuContent: Text(
                                        "Delete Family",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                                if (partOfFamilyValidator() &&
                                    !adminValidator()) ...[
                                  MLSubmenu(
                                      onClick: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LeaveFamily(
                                                    familyCode:
                                                        userValue.familyID,
                                                  )),
                                        );
                                      },
                                      submenuContent: Text(
                                        "Leave Family",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                                if (!partOfFamilyValidator()) ...[
                                  MLSubmenu(
                                      onClick: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateFamily()),
                                        );
                                      },
                                      submenuContent: Text(
                                        "Create Family",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white,
                                        ),
                                      )),
                                  MLSubmenu(
                                      onClick: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  JoinFamily()),
                                        );
                                      },
                                      submenuContent: Text(
                                        "Join Family",
                                        style: GoogleFonts.openSans(
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ]),

                          MLMenuItem(
                            leading: Icon(Icons.feedback, color: Colors.white),
                            content: Text(
                              "Contact Us",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUs()),
                              );
                            },
                          ),
                          MLMenuItem(
                            leading: partOfFamilyValidator()
                                ? Icon(
                                    Icons.mood,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.mood_bad,
                                    color: Colors.white,
                                  ),
                            content: Text(
                              "Family Status",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),
                            onClick: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => partOfFamilyValidator()
                                      ? OkalertDialog("Family Joined",
                                          "You belong to Rohit Family.")
                                      : OkalertDialog("Family not Joined",
                                          "You don't belong to any Family."));
                            },
                          ),
                        ]);
                  });
            } else if (snapshot.hasError) {
              return new MultiLevelDrawer(
                  backgroundColor: Color.fromRGBO(109, 49, 185, 0.9),
                  rippleColor: Colors.white,
                  subMenuBackgroundColor: Color.fromRGBO(253, 160, 41, 1),
                  header: Container(
                    // Header for Drawer
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),
                        Image.asset(
                          "assets/images/avatar.png",
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "User",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "Member",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                  ),
                  children: [
                    // Child Elements for Each Drawer Item
                    MLMenuItem(
                        leading: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        trailing: Icon(Icons.arrow_right, color: Colors.white),
                        content: Text(
                          "Account",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                          ),
                        ),
                        subMenuItems: [
                          MLSubmenu(
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new EditProfile()),
                              );
                            },
                            submenuContent: Text(
                              "Create Profile",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          MLSubmenu(
                              onClick: () {},
                              submenuContent: Text(
                                "Delete Account",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                ),
                              )),
                        ],
                        onClick: () {}),

                    MLMenuItem(
                      leading: Icon(Icons.people, color: Colors.white),
                      trailing: Icon(Icons.arrow_right, color: Colors.white),
                      content: Text(
                        "Family",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                        ),
                      ),
                      onClick: () {
                        showDialog(
                          context: context,
                          builder: (_) => OkalertDialog("Family",
                              "Please Create a profile to access this feature."),
                          barrierDismissible: true,
                        );
                      },
                    ),

                    MLMenuItem(
                      leading: Icon(Icons.feedback, color: Colors.white),
                      content: Text(
                        "Contact Us",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                        ),
                      ),
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ContactUs()),
                        );
                      },
                    ),
                  ]);
            } else {
              return LinearProgressIndicator();
            }
          }),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 30, bottom: 8.0),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -1),
                end: Offset.zero,
              ).animate(_animationController),
              child: FadeTransition(
                opacity: _animationController,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Color(interiorColor),
                        size: 30.0,
                      ),
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        child: Image.asset("assets/images/HomeLogo.png"),
                        onTap: () {
                          setState(() {
                            reassemble();
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.exit_to_app,
                        size: 30.0,
                        color: Color(interiorColor),
                      ),
                      onPressed: () async {
                        await _auth.signOut();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          StreamBuilder<UserValue>(
              stream: DataBaseService(uid: user_val.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserValue userValue = snapshot.data;
                  return FadeTransition(
                    opacity: _animationController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text((salutations() + ",\n " + userValue.name),
                              style: GoogleFonts.dancingScript(
                                  color: Color(interiorColor),
                                  fontSize: 35.0,
                                  letterSpacing: 1.0)),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Welcome",
                            style: GoogleFonts.dancingScript(
                                color: Colors.white,
                                fontSize: 35.0,
                                letterSpacing: 1.0)),
                      ],
                    ),
                  );
                } else {
                  return LinearProgressIndicator();
                }
              }),

//            Stack(
//              children: <Widget>[
//                CardScroll(currPage: currentIndex,),
//                Positioned.fill(
//                    child: PageView.builder(
//                        itemCount: images.length,
//                        controller: controller,
//                        reverse: true,
//                        itemBuilder: (context, index){
//                          return Container();
//                        }
//                    )
//                ),
//              ],
//            ),
          StreamBuilder<FamilyCodeValue>(
              stream: DataBaseService(uid: user_val.uid).codeData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  FamilyCodeValue familyCodeValue = snapshot.data;
//                  print(familyCodeValue.familyID);
                  return Flexible(
                    child: PageView.builder(
                        itemCount: images.length,
                        controller: controller,
                        reverse: true,
                        itemBuilder: (context, int index) {
                          bool active = index == currentIndex;
                          return CardPage(images[index], title[index], active,
                              familyCodeValue.familyID);
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Flexible(
                    child: PageView.builder(
                        itemCount: images.length,
                        controller: controller,
                        reverse: true,
                        itemBuilder: (context, int index) {
                          bool active = index == currentIndex;
                          return CardPage(
                              images[index], title[index], active, null);
                        }),
                  );
                } else {
                  return LinearProgressIndicator();
                }
              })
        ],
      ),
    );
  }

  CardPage(String images, String title, bool active, String famCode) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 20 : 150;

    return FadeTransition(
      opacity: _animationController,
      child: InkWell(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOutQuint,
          margin: EdgeInsets.only(top: top, bottom: 50, right: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage(images),
            ),
            boxShadow: [
              BoxShadow(
                  color: offsetColor,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ],
          ),
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontSize: 40, color: Colors.white),
          )),
        ),
        onTap: () {
          if (famCode == null) {
            showSnackBar("Please be a part of family to access this feature...",
                _scaffoldKey);
          } else {
//          print("famcode: "+famCode);
            switch (title) {
              case "To-Do List":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ToDoList(
                            code: famCode,
                          )),
                );
                break;

              case "Images":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CarouselSection(
                            famCode: famCode,
                          )),
                );
                break;

              case "Family Events":
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.BOTTOMSLIDE,
                  title: title,
                  desc: 'Under Construction...',
                  btnOkOnPress: () {},
                )..show();
                break;

              case "Recipe Zone":
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeZone(
                            famCode: famCode,
                          )),
                );
                break;

              default:
                print(title);
                break;
            }
          }
        },
      ),
    );
  }

  Widget OkalertDialog(String title, String content) {
    return AlertDialog(
      title: Text(
        title,
        style: GoogleFonts.openSans(
          color: Colors.white,
        ),
      ),
      content: Text(
        content,
        style: GoogleFonts.openSans(
          color: Colors.white,
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            "Okay",
            style: GoogleFonts.openSans(
              color: Colors.amber,
            ),
          ),
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
