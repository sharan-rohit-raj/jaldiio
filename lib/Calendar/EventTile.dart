/// ------------------------------------------------------------------------

/// [EventsTile]

/// ------------------------------------------------------------------------

/// Description: Displays all upcoming events

/// Author(s): Ravish

/// Date Approved: 14-07-2020

/// Date Created: 21-07-2020

/// Approved By: Everyone

/// Reviewed By: Kaish, Ravish

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. code - Family Code
///           2. events - Event Model

/// Output(s): 1. EventTile State - Widget

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 24th July, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Models/FamEvent.dart';
import 'package:jaldiio/Services/DataBaseService.dart';

class EventTile extends StatefulWidget {
  final EventModel events;
  String code;
  EventTile({this.events, this.code});

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  Icon icon = Icon(
    Icons.remove,
    color: Colors.deepPurpleAccent,
  );

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
          color: Colors.white,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            title: Text(widget.events.title,
                style: GoogleFonts.openSans(fontSize: 25, color: Colors.black)),
            subtitle: Text(
              widget.events.description + "\n" + widget.events.eventDate,
              style: GoogleFonts.openSans(fontSize: 15, color: Colors.black54),
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
                if (await _checkForInternetConnection()) {
                  print(widget.code);
                  await DataBaseService(famCode: widget.code)
                      .deleteEvent(widget.events.id);
                } else {
                  connectivityDialogBox(context);
                }
              },
            ),
          )),
    );
  }
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
