/// ------------------------------------------------------------------------

/// [Recipe View]

/// ------------------------------------------------------------------------

/// Description: Builds individual Recipe Pages

/// Author(s): Kaish, Sharan

/// Date Approved: 14-07-2020

/// Date Created: 20-07-2020

/// Approved By: Kaish, Sharan

/// Reviewed By: Ravish, Sharan

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. Family Code

/// Output(s): 1. Image
///            2. RecipeURL
///            3. Recipe Name

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 24th July, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Services/CloudStorageService.dart';
import 'package:jaldiio/Services/DataBaseService.dart';

class RecipeView extends StatefulWidget {
  String url;
  String id;
  String famCode;
  String recipe;
  RecipeView({Key key, @required this.url, this.id, this.famCode, this.recipe})
      : super(key: key);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
            title: "Delete s",
            desc: 'Are you sure you want to delete this recipe?',
            btnOkOnPress: () async {
              showInSnackBar("Please wait while we delete your recipe...");
              await CloudStorageService(famCode: widget.famCode)
                  .deleteImage(widget.id)
                  .then((value) => print("Success"));
              await DataBaseService(famCode: widget.famCode)
                  .deleteImg(widget.id);
              AwesomeDialog(
                dismissOnTouchOutside: false,
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                title: "Deleted",
                desc: 'We have successfully deleted your recipe.',
                btnOkOnPress: () async {
                  Navigator.pop(context);
                },
                btnOkText: "Okay",
                btnOkColor: Colors.deepPurpleAccent,
              )..show();
            },
            btnCancelOnPress: () {},
            btnOkText: "Delete",
            btnOkColor: Colors.red,
            btnCancelText: "Cancel",
            btnCancelColor: Colors.deepPurpleAccent,
          )..show();

//            AwesomeDialog(
//              context: context,
//              dialogType: DialogType.WARNING,
//              animType: AnimType.BOTTOMSLIDE,
//              title: "Image Deleted Successfully!",
//              desc: "",
//              btnOkOnPress: () async {
//                Navigator.pop(context);
//              },
//              btnOkText: "Okay",
//              btnOkColor: Colors.deepPurpleAccent,
//            )..show();

//            Navigator.pop(context);
        },
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(widget.url, fit: BoxFit.cover),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 350,
              height: 475,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black87, width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(widget.recipe,
                    style: GoogleFonts.openSans(
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
