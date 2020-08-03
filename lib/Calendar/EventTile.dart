import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Models/FamEvent.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

class EventTile extends StatefulWidget {

  final EventModel events;
  String code;
  EventTile({this.events, this.code});

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  Icon icon =  Icon(Icons.remove, color: Colors.deepPurpleAccent,);

  bool isdelete = false;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
          color: Colors.white,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            title: Text(widget.events.title, style: GoogleFonts.openSans(fontSize: 25, color: Colors.black)),
            subtitle: Text(widget.events.description + "\n" + widget.events.eventDate, style: GoogleFonts.openSans(
              fontSize: 15, color: Colors.black26
            ),),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: () async{
                print(widget.code);
                await DataBaseService(famCode: widget.code).deleteEvent(widget.events.id);
              } ,
            ),
          )

      ),
    );
  }
}
