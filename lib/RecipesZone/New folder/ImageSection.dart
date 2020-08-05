import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/ImagesSection/Carousels.dart';
import 'package:jaldiio/ImagesSection/ImageAdd.dart';
import 'package:jaldiio/Models/ImageUrls.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

class ImageSection extends StatefulWidget {
  String famCode;
  ImageSection({Key key, @required this.famCode}) : super(key: key);

  @override
  _ImageSectionState createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageAdd(
                      famCode: widget.famCode,
                    )),
          );
        },
        child: Icon(
          Icons.add,
          size: 50,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple[600],
      ),
      body:
//     Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 10.0, top: 50),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               IconButton(
//                 icon: Icon(
//                   Icons.arrow_back_ios,
//                   color: Colors.deepPurpleAccent,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               Text(
//                 "Image Section",
//                 style: GoogleFonts.openSans(
//                     color: Colors.deepPurpleAccent, fontSize: 30),
//               ),
//               SizedBox(
//                 width: 50,
//               )
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 90,
//         ),
          Stack(children: <Widget>[
        StreamProvider<List<ImageUrls>>.value(
            value: DataBaseService(famCode: widget.famCode).urls,
            child: Carousels()),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "Images Section",
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                width: 50,
              )
            ],
          ),
        ),
      ]),

//         SizedBox(
//           height: 60,
//         ),
//         FlatButton(
//           child: Text("Add an Image",
//             style: GoogleFonts.openSans(
//                 fontSize: 18,
//                 color: Colors.white),),
//           padding: EdgeInsets.only(left: 100, right: 100),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//               side: BorderSide(
//                   color: Colors.deepPurpleAccent)),
//           color: Colors.deepPurpleAccent,
//           onPressed: () async {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ImageAdd(famCode: widget.famCode,)),
//             );
//
//           },
//         ),
//       ],
//     ),
    );
  }
}
