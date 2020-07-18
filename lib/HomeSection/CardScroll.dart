import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/HomeSection/Data.dart';


var cardAspectRatio = 25.0/43.0;
var widgetAspectRatio = cardAspectRatio *1.2;

class CardScroll extends StatelessWidget {

  var currPage;
  var padding =20;
  var vertical = 20;
  CardScroll({this.currPage});
  List<Widget> cardList = new List();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints){
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;
          var safeWidth = width - 2*padding;
          var safeHeight = height - 2*padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;
          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft/2;

          for(var i =0 ; i <images.length;i++){
            var delta = i- currPage;
            bool isOnRight = delta > 0;

            var start = padding +max(primaryCardLeft - horizontalInset* -delta * (isOnRight ? 15 : 1),0.0);

            var card = Positioned.directional(
              top: padding + vertical * max(-delta,0.0),
              bottom: padding + vertical *max(-delta,0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(9.0, 18.0),
                        blurRadius: 50.0
                      )
                    ]
                  ),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                                image: new ExactAssetImage(images[i]),
                            fit: BoxFit.cover
                            ),
                          ),
                          child: new BackdropFilter(
                              filter: new ImageFilter.blur(
                                sigmaY: 3.5,
                                sigmaX: 3.5,
                              ),
                            child: new Container(
                              decoration: new BoxDecoration(
                                color: Colors.white.withOpacity(0.0),
                              ),
                            ),
                          ),
                          ),
                        Center(
                          child: Text(title[i], style: GoogleFonts.jaldi(
                            color: Colors.white,
                            fontSize: 50.0,
                          ),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(card);
          }
          return Stack(
            children: cardList,

          );
        },
      ),
    );
  }
}
