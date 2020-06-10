import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jaldiio/Services/auth.dart';
import 'package:jaldiio/ToDoList.dart';
import './Animation/FadeAnimation.dart';
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int _current =0;

  List images = ["https://images.unsplash.com/photo-1522426266214-ec2d2abb9ce0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1353&q=80",
  "https://images.unsplash.com/photo-1591238008815-d9a603f0db4f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=717&q=80",
  "https://images.unsplash.com/photo-1591227532336-85280d0cf355?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80"
  ];

  List<T>map<T>(List list, Function handler){
    List<T> result = [];
    for(var i = 0; i< list.length ;i++){
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Jaldi.io", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.orange,
      elevation: 0.0,
      actions: <Widget>[
        FlatButton.icon(
          onPressed: () async{
              await _auth.signOut();
          },
          icon: Icon(Icons.person),
          label: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.orange,
        ),
      ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CarouselSlider(
              height: 400.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: images.map((imgUrl) {
                  return Builder(
                    builder: (BuildContext context){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.green,
                        ),
                          child: Image.network(
                            imgUrl, 
                            fit: BoxFit.fill,
                            ),
                        );
                    },
                  );
              }).toList(),
            ),
            SizedBox(height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(
                images, (index, url){
                  return Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(vertical: 10.0, horizontal:20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? Colors.redAccent : Colors.green,
                    ),
                  );
                }
              ),

              
            ),

            SizedBox(
              height: 20,
              ),

              RaisedButton(
                color: Colors.purple[100],
                child: Text(
                  "To-Do List"
                  
                  ),
                onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToDoList()),
                    );
              },)

          ],
          
        ),
      ),
    );
  }
}

