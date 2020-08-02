import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:jaldiio/Models/FamEvent.dart';
import 'package:jaldiio/Calendar/Event_Add.dart';

class EventCalendar extends StatefulWidget {
  String code;
  EventCalendar({Key key, @required this.code}) : super(key: key);

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  CalendarController _calcontrol;
  Map<DateTime, List<dynamic>> _famevent;
  List<dynamic> _eventselected;

  @override
  void initState() {
    super.initState();
    _calcontrol = CalendarController();
    _famevent = {};
    _eventselected = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _famevent,
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                renderDaysOfWeek: true,
                  canEventMarkersOverflow: true,
                  todayColor: Color(0xffEA3914),
                  selectedColor: Color(0xffE4664B),
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
              onDaySelected: (date, events) {
                setState(() {
                  _eventselected = events;
                });
              },
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
                        color: Color(0xffEA3914),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _calcontrol,
            ),

          ],
        ),
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
    );
  }
}
