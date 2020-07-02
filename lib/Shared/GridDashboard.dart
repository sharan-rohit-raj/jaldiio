import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Contacts/ContactSection.dart';
import 'package:jaldiio/ImagesSection/CarouselSection.dart';
import 'package:jaldiio/ImagesSection/ImageAdd.dart';
import 'package:jaldiio/ImagesSection/ImageSection.dart';
import 'package:jaldiio/Models/FamilyCodeValue.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/ToDos/ToDoList.dart';
import 'package:provider/provider.dart';

class GridDashboard extends StatelessWidget {


  String name;
  GlobalKey<ScaffoldState> scaffoldKey;
  GridDashboard({Key key, @required this.name, this.scaffoldKey}) : super(key: key);
  Item contacts = new Item(
      title: "Family Contacts",
      image: "assets/images/phone.png"
  );
  Item family_events = new Item(
      title: "Family Events",
      image: "assets/images/calendar.png"
  );
  Item games = new Item(
      title: "Games",
  );

  Item images = new Item(
    title: "Images",
    image: "assets/images/camera.png"
  );

  Item recipe = new Item(
    title: "Recipe Zone",
      image: "assets/images/recipe.png"
  );
  Item todo = new Item(
      title: "To-Do List",
      image: "assets/images/todo_list.png"
  );

  void showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    List<Item> myList = [contacts, family_events, games, images, recipe, todo];
    var color = 0xff9782FF;
    final user_val = Provider.of<User>(context);

    return StreamBuilder<FamilyCodeValue>(
      stream: DataBaseService(uid: user_val.uid).codeData,
      builder: (context, snapshot) {

        if(snapshot.hasData && snapshot.data.familyID.isNotEmpty ){
          FamilyCodeValue code = snapshot.data;
          return Flexible(
              child: FadeAnimation(
                1,
                GridView.count(
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: myList.map((data) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(109, 93, 191, 0.50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: data.title == "Games" ? Icon(Icons.videogame_asset, color: Color.fromRGBO(255, 255, 255, 0.65),) : Image.asset(data.image),
                            iconSize: 61,
                            onPressed: () {
                              switch(data.title){
                                case "Family Contacts":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ContactSection(code: code.familyID,)),
                                  );
                                  break;
                                case "Family Events":
                                  print(data.title);
                                  break;
                                case "Games":
                                  print(data.title);
                                  break;
                                case "Images":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CarouselSection(famCode: code.familyID,)),
                                  );
                                  break;
                                case "Recipe Zone":
                                  print(data.title);
                                  break;
                                case "To-Do List":
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ToDoList(code: code.familyID,)),
                                  );
                                  break;

                              }
                            },
                          ),
//              Image.asset(
//                data.image,
////                width: 42,
//              ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            data.title,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                        ],
                      ),
                    );
                  }).toList(),

                ),
              ));
        }
        else{
          return Flexible(
              child: FadeAnimation(
                1,
                GridView.count(
                  childAspectRatio: 1.0,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  children: myList.map((data) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(109, 93, 191, 0.50),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: data.title == "Games" ? Icon(Icons.videogame_asset, color: Color.fromRGBO(255, 255, 255, 0.65),) : Image.asset(data.image),
                            iconSize: 61,
                            onPressed: () {
                              switch(data.title){
                                case "Family Contacts":
                                  showInSnackBar("Please create a family to access this functionality.");
                                  break;
                                case "Family Events":
                                  showInSnackBar("Please create a family to access this functionality.");
                                  break;
                                case "Games":
                                  showInSnackBar("Please create a family to access this functionality.");
                                  break;
                                case "Images":
                                  showInSnackBar("Please create a family to access this functionality.");
                                  break;
                                case "Recipe Zone":
                                  showInSnackBar("Please create a family to access this functionality.");
                                  break;
                                case "To-Do List":
                                  showInSnackBar("Please create a family to access this functionality.");
                                  break;

                              }
                            },
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            data.title,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),

                        ],
                      ),
                    );
                  }).toList(),

                ),
              ));
        }

      }
    );
  }
}

class Item {
  String title = "";
  String image = "";


  Item({this.title, this.image});
}
