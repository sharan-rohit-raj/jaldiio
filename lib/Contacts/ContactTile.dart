import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

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



  @override
  Widget build(BuildContext context) {
    String name_id = widget.contact.name.toLowerCase() + "_" + widget.contact.phNo.toString();
    final user_val = Provider.of<User>(context);
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
                    print(widget.code);
                    await DataBaseService(famCode: widget.code)
                        .deleteContactDoc(widget.contact.emaild);
                    //if user is joined update user's familyCode value in user_collection
                  if(widget.contact.joined){
                    await DataBaseService(uid: widget.contact.uid).updateJoined(false);
                    await DataBaseService(uid: widget.contact.uid).leaveFamily();
                  }

              } ,
              ),
            )

        ),
    );
  }
}
