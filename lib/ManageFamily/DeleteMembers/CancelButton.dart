import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelButton extends StatelessWidget {

  BuildContext deletecontext;

  CancelButton({Key key, @required this.deletecontext}) : super(key: key);

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
        Navigator.pop(context);
      },
    );
  }
}
