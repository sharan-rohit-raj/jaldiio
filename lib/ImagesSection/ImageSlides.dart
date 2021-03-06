/// ------------------------------------------------------------------------

/// [Image Slides]

/// ------------------------------------------------------------------------

/// Description: Builds SlideShow Page and handles Animations

/// Author(s): Sharan

/// Date Approved: 04-07-2020

/// Date Created: 10-07-2020

/// Approved By: Kaish, Sharan

/// Reviewed By: Kaish, Sharan

/// ------------------------------------------------------------------------

/// File(s) Accessed: NONE

/// File(s) Modified: NONE

/// ------------------------------------------------------------------------

/// Input(s): 1. famCode - Family Code
///           2. key - Image Querry

/// Output(s): 1. _image - Image

/// ------------------------------------------------------------------------

/// Error-Handling(s): 1. Check for Internet Connection
///                    2. Await for Synchronization

/// ------------------------------------------------------------------------

/// Modification(s): 1. Initial commit - 14th July, 2020
///                  2. Internet Connectivity Check added - 26th July, 2020

/// ------------------------------------------------------------------------

/// Fault(s): NONE

/// ------------------------------------------------------------------------

import 'dart:async';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/ImagesSection/ImageView.dart';
import 'package:jaldiio/Models/ImageTags.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/Shared/Loading.dart';

class ImageSlides extends StatefulWidget {
  String famCode;
  ImageSlides({Key key, @required this.famCode}) : super(key: key);

  @override
  _ImageSlidesState createState() => _ImageSlidesState();
}

class _ImageSlidesState extends State<ImageSlides>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
//  AnimationController _subHeadingAnimationController;
  final PageController ctrl = PageController(viewportFraction: 0.8);

  int currentPage = 0;
  String activeTag = 'favourites';
  Stream slides;

  //Check for Internet connectivity
  Future _checkForInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    print(widget.famCode);
    queryDb();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    Timer(Duration(milliseconds: 200), () => _animationController.forward());

    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: slides,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
//          print(snapshot.data);
            List slideList = snapshot.data.toList();
            return PageView.builder(
                controller: ctrl,
                itemCount: slideList.length + 1,
                itemBuilder: (context, int current) {
//                print(slideList.length);

                  if (current == 0) {
                    return _buildTagPage();
                  } else if (slideList.length >= current) {
//                  print(slideList[current-1]);
                    bool active = current == currentPage;
                    return _buildStoryPage(slideList[current - 1], active);
                  } else {
                    return Loading();
                  }
                });
          } else {
            return Loading();
          }
        });
  }

  Stream queryDb({String tag = 'Sad'}) {
    final CollectionReference familyCollection =
        Firestore.instance.collection('family_info');

    print(tag);
    print(widget.famCode);
    Query query = familyCollection
        .document(widget.famCode)
        .collection("images")
        .where("tag", arrayContains: tag);

    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    setState(() {
      activeTag = tag;
    });
  }

  _buildStoryPage(Map data, bool active) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return InkWell(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(data['url']),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black87,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ],
        ),
        child: Center(
            child: Text(
          data['name'],
          style: TextStyle(fontSize: 40, color: Colors.white),
        )),
      ),
      onTap: () async {
        if (await _checkForInternetConnection()) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImageView(
                      url: data['url'],
                      id: data['id'],
                      famCode: widget.famCode,
                    )),
          );
          print(data['name']);
        } else {
          connectivityDialogBox();
        }
      },
    );
  }

  _buildTagPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(-1, 0),
              end: Offset.zero,
            ).animate(_animationController),
            child: FadeTransition(
                opacity: _animationController,
                child: Text(
                  'Your Stories',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(
            height: 50,
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(-1, 0),
              end: Offset.zero,
            ).animate(_animationController),
            child: FadeTransition(
              opacity: _animationController,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Filter images with \nthe tags below.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FadeTransition(
            opacity: _animationController,
            child: Container(
              height: 200,
              width: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87,
                      blurRadius: 5,
                      offset: Offset(5, 5))
                ],
              ),
              child: StreamBuilder<ImageTags>(
                  stream: DataBaseService(famCode: widget.famCode).imgTagData,
                  builder: (context, snapshot) {
//                print("family: "+widget.famCode);
                    if (snapshot.hasData) {
                      ImageTags tagsData = snapshot.data;

                      void reorder(int oldIndex, int newIndex) {
                        if (newIndex > oldIndex) newIndex -= 1;

                        final String x = tagsData.tags.removeAt(oldIndex);
                        tagsData.tags.insert(newIndex, x);
                      }

                      return ReorderableListView(
                        padding: EdgeInsets.all(15),
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            reorder(oldIndex, newIndex);
                          });
                        },
                        children: tagsData.tags.map((index) {
                          return ListTile(
                            key: ObjectKey(index),
                            title: Text(
                              "$index",
                              style:
                                  GoogleFonts.openSans(color: Colors.black87),
                            ),
                            onLongPress: () async {
                              //Check for internet connectivity
                              if (await _checkForInternetConnection()) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.WARNING,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: "Delete Tag",
                                  desc: 'Do you wish to delete this tag?',
                                  btnOkOnPress: () async {
                                    await DataBaseService(
                                            famCode: widget.famCode)
                                        .deleteImgTag("$index");
                                  },
                                  btnCancelOnPress: () {},
                                  btnOkText: "Delete",
                                  btnOkColor: Colors.red,
                                  btnCancelColor: Colors.deepPurpleAccent,
                                )..show();
                              } else {
                                connectivityDialogBox();
                              }
                            },
                            onTap: () async {
                              //Check for internet connectivity
                              if (await _checkForInternetConnection()) {
                                queryDb(tag: '$index');
                              } else {
                                connectivityDialogBox();
                              }
                            },
                          );
                        }).toList(),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text("Emtpy"),
                      );
                    } else {
                      return Container(
                          height: 10,
                          width: 30,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.deepPurpleAccent,
                          ));
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  //Connectivity Error Dialog Box
  AwesomeDialog connectivityDialogBox() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Connectivity Error',
      desc: 'Hmm..looks like there is no connectivity...',
      btnOkOnPress: () {},
    )..show();
  }
}
