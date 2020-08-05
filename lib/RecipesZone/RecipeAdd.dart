/// ------------------------------------------------------------------------

/// [Recipe Add]

/// ------------------------------------------------------------------------

/// Description: Adds New Recipes

/// Author(s): Kaish, Sharan

/// Date Approved: 14-07-2020

/// Date Created: 19-07-2020

/// Approved By: Kaish, Sharan

/// Reviewed By: Ravish, Sharan

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. Family Code

/// Output(s): 1. Image
///            2. Tag List
///            3. Recipe Name

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Checks for invalid inputs
///                    2. Check for Internet Connection

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 24th July, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Services/CloudStorageService.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:string_validator/string_validator.dart';
import 'package:jaldiio/Shared/Loading.dart';

class RecipeAdd extends StatefulWidget {
  String famCode;

  RecipeAdd({Key key, @required this.famCode}) : super(key: key);

  @override
  _RecipeAddState createState() => _RecipeAddState();
}

class _RecipeAddState extends State<RecipeAdd> {
  File _image;
  final picker = ImagePicker();
  Future showPicker() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1).toLowerCase();
  }

  String imageIDgenerator(String name) {
    var random = Random.secure();
    var value = random.nextInt(1000000000);
    String code = value.toString();
    String id =
        capitalize(name.toLowerCase().trim().replaceAll(' ', '')) + "_" + code;
    return id;
  }

  final _nameController = TextEditingController(text: "");
  final _tag1 = TextEditingController(text: "");
  final _tag2 = TextEditingController(text: "");
  final _tag3 = TextEditingController(text: "");
  String imgName;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  List<String> tags;

  List<String> populateList(String tag1, String tag2, String tag3) {
    List<String> tags = new List<String>();
    tags.add('#' + capitalize(tag1));
    if (tag2.isNotEmpty) tags.add('#' + capitalize(tag2));
    if (tag3.isNotEmpty) tags.add('#' + capitalize(tag3));

    return tags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showPicker();
          print("image file: " + _image.toString());
//          tags = populateList(_tag1.text, _tag2.text, _tag3.text);
//          await DataBaseService(famCode: widget.famCode).updateTags(tags);
        },
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple[600],
      ),
      body: SingleChildScrollView(
        child: Column(
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Add Recipe",
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
              "Let your family know what smells so delicious",
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                  color: Colors.deepPurpleAccent, fontSize: 50),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Choose an image from your gallery.",
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
              child: _image != null
                  ? Image.file(
                      _image,
                      height: 300.0,
                      width: 300.0,
                    )
                  : Text(
                      "Choose an image to see a preview",
                      style: GoogleFonts.openSans(
                          color: Colors.grey, fontSize: 15),
                    ),
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
              child: Form(
                key: _formKey,
                child: FadeAnimation(
                  1,
                  Container(
//                      padding: EdgeInsets.all(8.0),
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
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Give a name for the recipe",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (val) => (val.length > 0) && isAlpha(val)
                                ? null
                                : "Please enter an valid name",
                            onChanged: (val) {},
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[100]),
                            ),
                          ),
                          child: TextFormField(
                            controller: _tag1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Set Tag 1",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (val) => (val.length > 0) && isAlpha(val)
                                ? null
                                : "Please enter a valid tag",
                            onChanged: (val) {},
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[100]),
                            ),
                          ),
                          child: TextFormField(
                            controller: _tag2,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Set Tag 2 (Optional)",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (val) =>
                                (isAlpha(val) && val.length > 0) ||
                                        val.length == 0
                                    ? null
                                    : "Please enter a valid tag",
                            onChanged: (val) {},
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey[100]),
                            ),
                          ),
                          child: TextFormField(
                            controller: _tag3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Set Tag 3 (Optional)",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (val) =>
                                (isAlpha(val) && val.length > 0) ||
                                        val.length == 0
                                    ? null
                                    : "Please enter a valid tag",
                            onChanged: (val) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            FlatButton(
              child: Text(
                "Upload",
                style: GoogleFonts.openSans(
                    fontSize: 18, color: Colors.deepPurpleAccent),
              ),
              color: Colors.white,
              padding: EdgeInsets.only(left: 100, right: 100),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.deepPurpleAccent)),
              onPressed: () async {
                //              final StorageReference firebaseRef = FirebaseStorage.instance.ref().child("images").child("Firstimg.png");
                //              final StorageUploadTask task = firebaseRef.putFile(_image);
                if (_formKey.currentState.validate()) {
                  String url = "";
                  List<String> tags =
                      populateList(_tag1.text, _tag2.text, _tag3.text);
                  String id = imageIDgenerator(_nameController.text);
                  StorageReference ref =
                      CloudStorageService(famCode: widget.famCode)
                          .Imagesref(id);
                  showInSnackBar("Please wait while we upload your recipe...");
                  StorageUploadTask upload = ref.putFile(_image);

                  StorageTaskSnapshot storageTaskSnapshot =
                      await upload.onComplete;

                  url = await storageTaskSnapshot.ref.getDownloadURL();
//                  print(url);
                  await DataBaseService(famCode: widget.famCode).addImageURL(
                      capitalize(_nameController.text).trim(), id, url, tags);
                  await DataBaseService(famCode: widget.famCode)
                      .updateTags(tags);
                  showInSnackBar("Recipe uploaded successfully!");
                }
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
