import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:jaldiio/Services/DataBaseService.dart';

class ContactTile extends StatefulWidget {

  final Contact contact;
  String code;
  ContactTile({this.contact, this.code});

  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  Icon icon =  Icon(Icons.remove, color: Colors.deepPurpleAccent,);

  bool isdelete = false;

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
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
              leading: widget.contact.joined?
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Icon(Icons.check_circle, color: Colors.green,),
              ) :
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Icon(Icons.check_circle_outline, color: Colors.grey),
              ),
              title: Text(widget.contact.name, style: GoogleFonts.openSans(
                fontSize: 25,

              ),),
              subtitle: Text(widget.contact.emaild + "\n" + widget.contact.phNo.toString(),
              style: GoogleFonts.openSans(
                fontSize: 15
              ),),
              isThreeLine: true,
              trailing: IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.red,),
                onPressed: () async{
                  if(await _checkForInternetConnection()){
                    print(widget.code);
                    await DataBaseService(famCode: widget.code)
                        .deleteContactDoc(widget.contact.emaild);
                    //if user is joined update user's familyCode value in user_collection
                    if(widget.contact.joined){
                      await DataBaseService(uid: widget.contact.uid).updateJoined(false);
                      await DataBaseService(uid: widget.contact.uid).leaveFamily();
                    }
                  } else  {connectivityDialogBox(context);}
              } ,
              ),
            )

        ),
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
