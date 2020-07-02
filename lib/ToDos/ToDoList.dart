import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Models/Task.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/ToDos/AddTask.dart';
import 'package:jaldiio/ToDos/Tasks.dart';
import 'package:provider/provider.dart';

class ToDoList extends StatefulWidget {
  String code;
  ToDoList({Key key, @required this.code}) : super(key: key);
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Task>>.value(
      value: DataBaseService(famCode: widget.code).tasks,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask()),
            );
          },
          child: Icon(Icons.add, size: 50,color: Colors.white,),
          backgroundColor: Colors.deepPurple[600],


        ),
        body: Stack(
          // alignment: Alignment.center,

          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/teamtodo.png"),
                  fit: BoxFit.contain,
                ),
              ),
          ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.deepPurpleAccent,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "To-Do List",
                    style: GoogleFonts.openSans(
                        color: Colors.deepPurpleAccent, fontSize: 30),
                  ),
                  SizedBox(
                    width: 50,
                  )
                ],
              ),
            ),

            DraggableScrollableSheet(
              maxChildSize: 0.85,
              builder: (BuildContext context, ScrollController scrollController){
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(193, 190, 235, 0.9),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),

                  ),
                  child: Tasks(scrollController: scrollController, code: widget.code),

                );
              },
            ),

          ],
        ),
      ),
    );
  }
}