//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Models/ImageUrls.dart';
import 'package:jaldiio/Shared/Loading.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Carousels extends StatefulWidget {
  @override
  _CarouselsState createState() => _CarouselsState();
}

class _CarouselsState extends State<Carousels> {
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final imageURLs = Provider.of<List<ImageUrls>>(context);
    var urls = new List();
    int i = 0;

    if (imageURLs != null) {
      if (imageURLs.isNotEmpty) {
        while (i < imageURLs.length) {
          urls.add(imageURLs[i].url);
          i++;
        }
      } else {
        urls.add(
            "https://images.unsplash.com/photo-1591227532336-85280d0cf355?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80");
      }
      bool play = true;

      return Carousel(
        boxFit: BoxFit.cover,
        images: urls.map((imgUrl) {
          return Builder(
            builder: (BuildContext context) {
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
        animationCurve: Curves.linearToEaseOut,
        animationDuration: Duration(milliseconds: 2000),
        autoplayDuration: Duration(seconds: 10),
        autoplay: play,
        onImageTap: (value){
          setState(() {
            play = !play;
          });
          print(value);
      },

      );

//      return CarouselSlider(
//        height: 520.0,
//        initialPage: 0,
//        enlargeCenterPage: true,
//        autoPlay: true,
//        reverse: false,
//        enableInfiniteScroll: true,
//        autoPlayInterval: Duration(seconds: 20),
//        autoPlayAnimationDuration: Duration(milliseconds: 5000),
//        pauseAutoPlayOnTouch: Duration(seconds: 10),
//        scrollDirection: Axis.horizontal,
//        onPageChanged: (index) {
//          setState(() {
//            _current = index;
//          });
//        },
//        items: urls.map((imgUrl) {
//          return Builder(
//            builder: (BuildContext context) {
//              return Container(
//                width: MediaQuery
//                    .of(context)
//                    .size
//                    .width,
//                margin: EdgeInsets.symmetric(horizontal: 10.0),
//                decoration: BoxDecoration(
//                  color: Colors.green,
//                ),
//                child: Image.network(
//                  imgUrl,
//                  fit: BoxFit.fill,
//                ),
//              );
//            },
//          );
//        }).toList(),
//      );
    } else {
      return Loading();
    }
  }
}
