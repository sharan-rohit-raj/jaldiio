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
  Future _checkForInternetConnection() async{
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
        onPressed: () async{

          if(await _checkForInternetConnection()){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImageAdd(famCode: famCode,)),
            );
          }else{
            connectivityDialogBox(context);
          }

        },
        child: Icon(Icons.add_photo_alternate, size: 40,color: Colors.white,),
        backgroundColor: Colors.deepPurple[600],


      ),
      body: ImageSlides(famCode: famCode,),
    );
  }
  //Connectivity Error Dialog Box
  AwesomeDialog connectivityDialogBox(BuildContext context){
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