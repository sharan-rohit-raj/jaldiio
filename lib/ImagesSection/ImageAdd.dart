import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Services/CloudStorageService.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/Shared/Loading.dart';

class ImageAdd extends StatefulWidget {
  String famCode;

  ImageAdd({Key key, @required this.famCode}) : super(key: key);

  @override
  _ImageAddState createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
  File _image;
  final picker = ImagePicker();
  Future showPicker() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

  final _nameController = TextEditingController(text: "");
  String imgName;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showPicker();
          print("image file: " + _image.toString());
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
                    "Add Image",
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
              "Let your family know what you are upto!",
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
                              hintText: "Give a name for the image",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (val) => val.length > 0
                                ? null
                                : "Please enter an valid name",
                            onChanged: (val) {

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30
            ),
            FlatButton(
              child: Text("Upload",
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Colors.deepPurpleAccent),),
              color: Colors.white,
              padding: EdgeInsets.only(left: 100, right: 100),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                      color: Colors.deepPurpleAccent)),
              onPressed: () async {
                //              final StorageReference firebaseRef = FirebaseStorage.instance.ref().child("images").child("Firstimg.png");
                //              final StorageUploadTask task = firebaseRef.putFile(_image);
                if(_formKey.currentState.validate()){
                  String url = "";
                  StorageReference ref = CloudStorageService(famCode: widget.famCode).
                  Imagesref(capitalize(_nameController.text));
                  showInSnackBar("Please wait while we upload your image...");
                  StorageUploadTask upload =  ref.putFile(_image);

                  StorageTaskSnapshot storageTaskSnapshot = await upload.onComplete;

                  url = await storageTaskSnapshot.ref.getDownloadURL();
//                  print(url);
                  await DataBaseService(famCode: widget.famCode).addImageURL(capitalize(_nameController.text), url);
                  showInSnackBar("Image uploaded successfully!");

                }

              },
            ),
            FlatButton(
              child: Text("Delete",
                style: GoogleFonts.openSans(
                    fontSize: 18,
                    color: Colors.white),),
              padding: EdgeInsets.only(left: 100, right: 100),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                      color: Colors.deepPurpleAccent)),
              color: Colors.deepPurpleAccent,
              onPressed: () async {

                if(_formKey.currentState.validate()){
                  await CloudStorageService(famCode: widget.famCode)
                      .deleteImage(_nameController.text);
                  showInSnackBar("Image deleted succesfully!");
                }

              },
            ),
            SizedBox(
                height: 30
            ),
          ],
        ),
      ),
    );
  }

}
