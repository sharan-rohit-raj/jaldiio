import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jaldiio/Models/FamEvent.dart';
import 'package:jaldiio/Calendar/EventTile.dart';
import 'package:provider/provider.dart';

class Events extends StatefulWidget {
  ScrollController scrollController;
  String code;

  Events({Key key, @required this.scrollController,this.code}) : super(key: key);
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    final qevents = Provider.of<List<EventModel>>(context);
    return ListView.builder(
      itemCount: qevents == null ? 0 : qevents.length,
//      controller: scrollController,
      itemBuilder: (context, index) {
        return EventTile(
          events: qevents[index],
          code: widget.code,
        );
      },
      controller: widget.scrollController,
    );
  }
}

