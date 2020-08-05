import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelButton extends StatelessWidget {

  BuildContext deletecontext;

  CancelButton({Key key, @required this.deletecontext}) : super(key: key);

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
    return FlatButton(
      padding: EdgeInsets.only(left: 100, right: 100),
      color: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              color: Colors.deepPurpleAccent)),
      child: Text(
        "Cancel",
        style: GoogleFonts.openSans(
            fontSize: 18,
            color: Colors.white),
      ),
      onPressed: () async{
        if(await _checkForInternetConnection()){
          Navigator.pop(context);
        } else  {connectivityDialogBox(context);}
      },
    );
  }
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
