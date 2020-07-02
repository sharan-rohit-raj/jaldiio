import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/ImagesSection/Carousels.dart';
import 'package:jaldiio/ImagesSection/ImageAdd.dart';
import 'package:jaldiio/ImagesSection/SlideShow.dart';
import 'package:jaldiio/Models/ImageUrls.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

class CarouselSection extends StatelessWidget {
  final PageController ctrl = PageController();
  final String famCode;

  CarouselSection({Key key, @required this.famCode}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ImageAdd(famCode: famCode,)),
          );
        },
        child: Icon(Icons.add_photo_alternate, size: 40,color: Colors.white,),
        backgroundColor: Colors.deepPurple[600],


      ),
      body: SlideShow(),
    );
  }
}


