/// ------------------------------------------------------------------------

/// [Events]

/// ------------------------------------------------------------------------

/// Description: Stores individual Events

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
///           2. scrollController - Scroll Controller

/// Output(s): 1. Events State - Widget

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 24th July, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jaldiio/Models/FamEvent.dart';
import 'package:jaldiio/Calendar/EventTile.dart';
import 'package:provider/provider.dart';

class Events extends StatefulWidget {
  ScrollController scrollController;
  String code;

  Events({Key key, @required this.scrollController, this.code})
      : super(key: key);
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
