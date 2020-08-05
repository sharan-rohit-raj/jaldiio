/// ------------------------------------------------------------------------

/// [ContactList]

/// ------------------------------------------------------------------------

/// Description: List of contacts

/// Author(s): Sharan

/// Date Approved: 14-06-2020

/// Date Created: 21-06-2020

/// Approved By: Everyone

/// Reviewed By: Sahil

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. code - Family Code
///           2. scrollController - Scroll Controller

/// Output(s): 1. ContactList - State Widget

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 24th June, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jaldiio/Contacts/ContactTile.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:provider/provider.dart';

class ContactList extends StatefulWidget {
  String code;
  ScrollController scrollController;
  ContactList({Key key, @required this.code, this.scrollController})
      : super(key: key);

//  GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _ContactListState createState() =>
      _ContactListState(scrollController: scrollController);
}

class _ContactListState extends State<ContactList> {
  ScrollController scrollController;
  _ContactListState({this.scrollController});
  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<List<Contact>>(context);

    return ListView.builder(
      itemCount: contacts == null ? 0 : contacts.length,
//      controller: scrollController,
      itemBuilder: (context, index) {
        return ContactTile(
          contact: contacts[index],
          code: widget.code,
        );
      },
      controller: scrollController,
    );
  }
}
