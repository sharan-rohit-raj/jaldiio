import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:jaldiio/Shared/Loading.dart';

class SlideShow extends StatefulWidget {

  String famCode;
  SlideShow({Key key, @required this.famCode}) : super(key: key);

  @override
  _SlideShowState createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {

  final PageController ctrl = PageController(viewportFraction: 0.8);

  int currentPage =0;
  String activeTag = 'favourites';
  Stream slides;

  @override
  void initState(){
    print(widget.famCode);
    queryDb();


    ctrl.addListener(() {
      int next  = ctrl.page.round();

      if(currentPage != next){
        setState(() {
            currentPage = next;
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: slides,
      builder: (context, AsyncSnapshot snapshot) {


        if(snapshot.hasData){
//          print(snapshot.data);
          List slideList = snapshot.data.toList();
          return PageView.builder(
              controller: ctrl,
              itemCount: slideList.length+1,
              itemBuilder: (context, int current){
//                print(slideList.length);

                if(current ==0){
                  return _buildTagPage();
                }
                else if (slideList.length >= current){
//                  print(slideList[current-1]);
                  bool active = current == currentPage;
                  return _buildStoryPage(slideList[current -1], active);
                }
                else{
                  return Loading();
                }

              }
          );
        }
        else{
          return Loading();
        }


      }
    );
  }

  Stream queryDb({String tag = 'Sad'}) {
    final CollectionReference familyCollection =
    Firestore.instance.collection('family_info');

  print(tag);
    Query query = familyCollection
        .document("sharancancodewithflutter")
        .collection("images").where("tag", arrayContains: tag);


//     query.getDocuments().then((value){
//       List<DocumentSnapshot> documents = value.documents;
//       int i =0;
//       while(i < documents.length){
//         print(documents[i].documentID.toString());
//         i++;
//       }
//     });


    slides = query.snapshots().map((list) => list.documents.map((doc) => doc.data));

//    print(slides);

    setState(() {
      activeTag = tag;
    });
  }

   _buildStoryPage(Map data, bool active){
      final double blur = active ? 30: 0;
      final double offset =active ? 20:0;
      final double top = active ? 100:200;

      return InkWell(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOutQuint,
          margin: EdgeInsets.only(top: top, bottom:  50, right: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image : DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(data['url']),
            ),
            boxShadow: [BoxShadow(color:Colors.black87, blurRadius: blur, offset: Offset(offset, offset))],
          ),
          child: Center(
              child:Text(
            data['name'], style: TextStyle(fontSize: 40, color: Colors.white),
          )),
        ),
        onTap: () {
          print(data['name']);
        },
      );
  }

   _buildTagPage(){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text('Your Stories' , style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          Text('FILTER', style : TextStyle(color: Colors.black26)),
          _buildButton('Favorites'),
          _buildButton('Happy'),
          _buildButton('Sad'),
        ],
      ),
    );
  }

  _buildButton(tag){
    Color color = tag == activeTag ? Colors.purple : Colors.white;
    return FlatButton(color: color,child: Text('$tag'),onPressed: () => queryDb(tag: tag),);
  }
}