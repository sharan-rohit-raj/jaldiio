/// ------------------------------------------------------------------------

/// [Event Add]

/// ------------------------------------------------------------------------

/// Description: Add New Events

/// Author(s): Ravish

/// Date Approved: 14-07-2020

/// Date Created: 21-07-2020

/// Approved By: Everyone

/// Reviewed By: Bhavya, Ravish

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. note - EventModel

/// Output(s): 1. Event State

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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Models/FamilyCodeValue.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';
import 'package:jaldiio/Models/FamEvent.dart';

class EventAdd extends StatefulWidget {
  final EventModel note;

  const EventAdd({Key key, this.note}) : super(key: key);

  @override
  _EventAddState createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _head;
  TextEditingController _details;
  DateTime _Dateofevent;
  final _Keyform = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

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
  void initState() {
    super.initState();
    _head = TextEditingController(
        text: widget.note != null ? widget.note.title : "");
    _details = TextEditingController(
        text: widget.note != null ? widget.note.description : "");
    _Dateofevent = DateTime.now();
    processing = false;
  }

  String code;

  @override
  Widget build(BuildContext context) {
    final user_val = Provider.of<User>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Add Event',
              style: GoogleFonts.openSans(
                fontSize: 28,
                color: Colors.deepPurpleAccent,
              )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.deepPurpleAccent,
            onPressed: () async {
              if (await _checkForInternetConnection()) {
                Navigator.pop(context);
              } else {
                connectivityDialogBox(context);
              }
            },
          ),
          centerTitle: true,
        ),
        key: _key,
      ),
      body: Form(
        key: _Keyform,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _head,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter title" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _details,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter description" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event Details",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Date (YYYY-MM-DD)"),
                subtitle: Text(
                    "${_Dateofevent.year} - ${_Dateofevent.month} - ${_Dateofevent.day}"),
                onTap: () async {
                  DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: _Dateofevent,
                      firstDate: DateTime(_Dateofevent.year - 5),
                      lastDate: DateTime(_Dateofevent.year + 5),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: ThemeData.dark(),
                          child: child,
                        );
                      });
                  if (picked != null) {
                    setState(() {
                      _Dateofevent = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 10.0),
              StreamBuilder<FamilyCodeValue>(
                  stream: DataBaseService(uid: user_val.uid).codeData,
                  builder: (context, snapshotCode) {
                    return FlatButton(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      color: Color(0xffF78D00),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Text(
                        "Save",
                        style: style.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if (await _checkForInternetConnection()) {
                          if (_Keyform.currentState.validate()) {
                            code = snapshotCode.data.familyID;

                            String date = _Dateofevent.day.toString() +
                                "/" +
                                _Dateofevent.month.toString() +
                                "/" +
                                _Dateofevent.year.toString();

                            await DataBaseService(famCode: code)
                                .updateEvents(_head.text, _details.text, date);

                            Navigator.pop(context);
                          }
                        } else {
                          connectivityDialogBox(context);
                        }
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _head.dispose();
    _details.dispose();
    super.dispose();
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
