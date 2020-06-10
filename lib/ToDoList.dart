import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[600],
      body: Stack(
        // alignment: Alignment.center,

        children: <Widget>[
          Container(
        ),
          Positioned(
            child: Text("To-dos", style: TextStyle(color: Colors.white, fontSize: 40), ),
            top:40,
            left:20,
          ),

          DraggableScrollableSheet(
            maxChildSize: 0.85,
            builder: (BuildContext context, ScrollController scrollController){
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),

                    ),
                    child: ListView.builder(
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text("Task No $index", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
                          subtitle: Text("This is the detail of Task No $index", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),),
                          trailing: Icon(Icons.check_circle, color: Colors.greenAccent, ),
                          isThreeLine: true,
                        );
                      },
                      controller: scrollController,
                      itemCount: 10,
                    ),
              );
            }
          ),

        ],
      ),
    );
  }
}