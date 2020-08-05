/// ------------------------------------------------------------------------

/// [ImageSection Wrapper]

/// ------------------------------------------------------------------------

/// Description: Builds the entire ImageSection State from here

/// Author(s): Sharan

/// Date Approved: 04-07-2020

/// Date Created: 10-07-2020

/// Approved By: Kaish, Sharan

/// Reviewed By: Kaish, Sharan

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. famCode - Family Code

/// Output(s): 1. _image - Image
///            2. ImageSection - ImageSection State Widget

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 14th July, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/ImagesSection/ImageAdd.dart';
import 'package:jaldiio/ImagesSection/ImageSlides.dart';
import 'package:jaldiio/Models/ImageUrls.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

class ImageSection extends StatelessWidget {
  final PageController ctrl = PageController();
  final String famCode;

  ImageSection({Key key, @required this.famCode}) : super(key: key);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await _checkForInternetConnection()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImageAdd(
                        famCode: famCode,
                      )),
            );
          } else {
            connectivityDialogBox(context);
          }
        },
        child: Icon(
          Icons.add_photo_alternate,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple[600],
      ),
      body: ImageSlides(
        famCode: famCode,
      ),
    );
  }

  //Connectivity Error Dialog Box
  AwesomeDialog connectivityDialogBox(BuildContext context) {
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
