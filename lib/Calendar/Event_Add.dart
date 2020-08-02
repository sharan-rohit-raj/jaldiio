import 'package:jaldiio/Models/FamEvent.dart';
import 'package:flutter/material.dart';


class EventAdd extends StatefulWidget {
  final EventModel note;

  const EventAdd({Key key, this.note}) : super(key: key);

  @override
  _EventAddState createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _head;
  TextEditingController _details;
  DateTime _Dateofevent;
  final _Keyform = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;

  @override
  void initState() {
    super.initState();
    _head = TextEditingController(text: widget.note != null ? widget.note.title : "");
    _details = TextEditingController(text:  widget.note != null ? widget.note.description : "");
    _Dateofevent = DateTime.now();
    processing = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(80.0),
      child: AppBar(
        backgroundColor: Color(0xff211175),
        title: Text('Add Event',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      key: _key,
      ),
      body: Form(
        key: _Keyform,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _head,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter title" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _details,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter description" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Event Details",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text("Date (YYYY-MM-DD)"),
                subtitle: Text("${_Dateofevent.year} - ${_Dateofevent.month} - ${_Dateofevent.day}"),
                onTap: ()async{
                  DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: _Dateofevent,
                      firstDate: DateTime(_Dateofevent.year-5),
                      lastDate: DateTime(_Dateofevent.year+5),
                    builder: (BuildContext context, Widget child){
                      return Theme(
                        data: ThemeData.dark(),
                        child: child,
                      );
                    }

                  );
                  if(picked != null) {
                    setState(() {
                      _Dateofevent = picked;
                    });
                  }
                },
              ),

              SizedBox(height: 10.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xffF78D00),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_Keyform.currentState.validate()) {
                        setState(() {
                          processing = true;
                        });
                        /*if(widget.note != null) {
                          await eventDBS.updateData(widget.note.id,{
                            "title": _head.text,
                            "description": _details.text,
                            "event_date": widget.note.eventDate
                          });
                        }else{
                          await eventDBS.createItem(EventModel(
                              title: _head.text,
                              description: _details.text,
                              eventDate: DateTime.now()
                          ));
                        }*/
                        Navigator.pop(context);
                        setState(() {
                          processing = false;
                        });
                      }
                    },
                    child: Text(
                      "Save",
                      style: style.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _head.dispose();
    _details.dispose();
    super.dispose();
  }
}