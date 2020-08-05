/// ------------------------------------------------------------------------

/// [RecipeZone Wrapper]

/// ------------------------------------------------------------------------

/// Description: Builds the entire RecipeZone State from here

/// Author(s): Kaish, Sharan

/// Date Approved: 14-07-2020

/// Date Created: 19-07-2020

/// Approved By: Kaish, Sharan

/// Reviewed By: Ravish, Sharan

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. Family Code

/// Output(s): 1. Image
///            2. RecipeURL
///            3. Recipe Name

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 24th July, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

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
