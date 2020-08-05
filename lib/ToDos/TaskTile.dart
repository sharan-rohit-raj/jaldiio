/// ------------------------------------------------------------------------

/// [TaskTile]

/// ------------------------------------------------------------------------

/// Description: Builds a Tile that stores and displays tasks

/// Author(s): Sharan

/// Date Approved: 14-06-2020

/// Date Created: 17-06-2020

/// Approved By: Sahil, Sharan

/// Reviewed By: Kaish, Sharan

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. code - Family Code
///           2. task - Task

/// Output(s): 1. TaskTile - State Widget

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 18th June, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Models/Task.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  String code;
  TaskTile({this.task, this.code});
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
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

  List<bool> isSelected = List.generate(2, (_) => false);
  @override
  Widget build(BuildContext context) {
    bool isChecked = widget.task.check;
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
            leading: Checkbox(
              value: isChecked,
              checkColor: Colors.white,
              activeColor: Colors.green,
              onChanged: (value) async {
                setState(() {
                  isChecked = value;
                });
                await DataBaseService(famCode: widget.code)
                    .updateTaskCheck(isChecked, widget.task.id);
              },
            ),
            title: Text(
              widget.task.task,
              style: GoogleFonts.openSans(
                fontSize: 25,
                color: Color(0xFF585583),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.deepPurpleAccent),
              onPressed: () async {
                if (await _checkForInternetConnection()) {
                  print(widget.code);
                  await DataBaseService(famCode: widget.code)
                      .deleteTask(widget.task.id);
                } else {
                  connectivityDialogBox(context);
                }
              },
            )),
      ),
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
