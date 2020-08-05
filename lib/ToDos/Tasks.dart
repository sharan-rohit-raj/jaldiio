/// ------------------------------------------------------------------------

/// [Tasks]

/// ------------------------------------------------------------------------

/// Description: Builds a Task block that displays individual task

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
///           2. scrollController - Scroll Controller

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

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jaldiio/Models/Task.dart';
import 'package:jaldiio/ToDos/TaskTile.dart';
import 'package:provider/provider.dart';

class Tasks extends StatefulWidget {
  ScrollController scrollController;
  String code;

  Tasks({Key key, @required this.scrollController, this.code})
      : super(key: key);
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<List<Task>>(context);
    return ListView.builder(
      itemCount: tasks == null ? 0 : tasks.length,
//      controller: scrollController,
      itemBuilder: (context, index) {
        return TaskTile(
          task: tasks[index],
          code: widget.code,
        );
      },
      controller: widget.scrollController,
    );
  }
}
