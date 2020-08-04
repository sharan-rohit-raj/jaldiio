import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jaldiio/Services/CloudStorageService.dart';
import 'package:jaldiio/Services/DataBaseService.dart';

class ImageView extends StatefulWidget {
  String url;
  String id;
  String famCode;
  ImageView({Key key, @required this.url, this.id, this.famCode})
      : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  //Check for Internet connectivity
  Future _checkForInternetConnection() async {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //Check for internet connectivity
            if (await _checkForInternetConnection()) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.WARNING,
                animType: AnimType.BOTTOMSLIDE,
                title: "Delete Image",
                desc: 'Are you sure you want to delete this image?',
                btnOkOnPress: () async {
                  //Check for internet connectivity
                  if (await _checkForInternetConnection()) {
                    showInSnackBar("Please wait while we delete your image...");
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
                      desc: 'We have successfully deleted your image.',
                      btnOkOnPress: () async {
                        Navigator.pop(context);
                      },
                      btnOkText: "Okay",
                      btnOkColor: Colors.deepPurpleAccent,
                    )..show();
                  } else {
                    connectivityDialogBox();
                  }
                },
                btnCancelOnPress: () {},
                btnOkText: "Delete",
                btnOkColor: Colors.red,
                btnCancelText: "Cancel",
                btnCancelColor: Colors.deepPurpleAccent,
              )..show();
            } else {
              connectivityDialogBox();
            }
          },
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepPurple[600],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.url,
              ),
            ),
          ),
        ));
  }

  //Connectivity Error Dialog Box
  AwesomeDialog connectivityDialogBox() {
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
