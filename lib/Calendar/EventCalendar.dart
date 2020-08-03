import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:jaldiio/Models/FamEvent.dart';
import 'package:jaldiio/Calendar/Event_Add.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:jaldiio/Calendar/Events.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';


class EventCalendar extends StatefulWidget {
  String code;
  EventCalendar({Key key, @required this.code}) : super(key: key);

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  CalendarController _calcontrol;
  Map<DateTime, List<dynamic>> _famevent;

  @override
  void initState() {
    super.initState();
    _calcontrol = CalendarController();
    _famevent = {};
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<EventModel>>.value(
        value: DataBaseService(famCode: widget.code).events,
    child: Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(80.0),
    child: AppBar(
        backgroundColor: Color(0xff211175),
        title: Text('Family Events',
            style: TextStyle(
            fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
      centerTitle: true,
      )),
      body: Stack(
          children: <Widget>[
            TableCalendar(
              events: _famevent,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                renderDaysOfWeek: true,
                  canEventMarkersOverflow: true,
                  todayColor: Color(0xffEA3914),
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                decoration: BoxDecoration(
                  color: Color(0xffE4E3E6),
                ),
                formatButtonDecoration: BoxDecoration(
                  color: Color(0xffF78D00),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffE4664B),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xffE4664B),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _calcontrol,
            ),
            DraggableScrollableSheet(
                initialChildSize: 0.3,
                maxChildSize: 0.6,
                builder: (BuildContext context, ScrollController scrollController){
                  return Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(193, 190, 235, 1),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                    ),
                    child: Events(scrollController: scrollController, code: widget.code),
                  );
                }
            ),

          ],

        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventAdd()),
          );
        },
        child: Icon(Icons.add, size: 50,color: Colors.white,),
        backgroundColor: Colors.deepPurple[600],


      ),
    ),
    );
  }
}