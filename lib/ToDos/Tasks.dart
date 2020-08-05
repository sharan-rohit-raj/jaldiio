import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:jaldiio/Models/Task.dart';
import 'package:jaldiio/ToDos/TaskTile.dart';
import 'package:provider/provider.dart';

class Tasks extends StatefulWidget {
  ScrollController scrollController;
  String code;

  Tasks({Key key, @required this.scrollController,this.code}) : super(key: key);
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

