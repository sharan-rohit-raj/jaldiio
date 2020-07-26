import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:jaldiio/RecipesZone/Carousels.dart';
import 'package:jaldiio/RecipesZone/RecipeAdd.dart';
import 'package:jaldiio/RecipesZone/RecipeSlideShow.dart';
import 'package:jaldiio/Models/ImageUrls.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

class RecipeZone extends StatelessWidget {
  final PageController ctrl = PageController();
  final String famCode;

  RecipeZone({Key key, @required this.famCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeAdd(
                      famCode: famCode,
                    )),
          );
        },
        child: Icon(
          Icons.add_photo_alternate,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple[600],
      ),
      body: RecipeSlideShow(
        famCode: famCode,
      ),
    );
  }
}
