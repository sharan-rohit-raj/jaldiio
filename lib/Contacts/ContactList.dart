import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jaldiio/Contacts/ContactTile.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:provider/provider.dart';

class ContactList extends StatefulWidget {
  String code;
  ScrollController scrollController;
  ContactList({Key key, @required this.code, this.scrollController}) : super(key: key);

//  GlobalKey<ScaffoldState> scaffoldKey;
  @override
  _ContactListState createState() => _ContactListState(scrollController: scrollController);
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

