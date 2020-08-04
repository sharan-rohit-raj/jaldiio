import 'dart:io';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';

class ContactTile extends StatefulWidget {
  final Contact contact;
  String code;
  ContactTile({this.contact, this.code});

  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  Icon icon = Icon(
    Icons.remove,
    color: Colors.deepPurpleAccent,
  );

  bool isdelete = false;

  @override
  Widget build(BuildContext context) {
    String name_id = widget.contact.name.toLowerCase() +
        "_" +
        widget.contact.phNo.toString();
    final user_val = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: widget.contact.joined
                ? Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          imageUrl: widget.contact.photoURL == null
                              ? randomImgGen()
                              : widget.contact.photoURL,
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                        )),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/images/avatar_prof.png",
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            title: Text(
              widget.contact.name,
              style: GoogleFonts.openSans(
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              widget.contact.emaild + "\n" + widget.contact.phNo.toString(),
              style: GoogleFonts.openSans(fontSize: 15),
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(
                Icons.remove_circle,
                color: Colors.red,
              ),
              onPressed: () async {
                //Check for internet connectivity
                if (await _checkForInternetConnection()) {
                  print(widget.code);
                  await DataBaseService(famCode: widget.code)
                      .deleteContactDoc(widget.contact.emaild);
                  //if user is joined update user's familyCode value in user_collection
                  if (widget.contact.joined) {
                    await DataBaseService(uid: widget.contact.uid)
                        .updateJoined(false);
                    await DataBaseService(uid: widget.contact.uid)
                        .leaveFamily();
                  }
                } else {
                  connectivityDialogBox();
                }
              },
            ),
          )),
    );
  }

  //Picks a random image
  String randomImgGen() {
    List<String> images = [
      "https://i.pinimg.com/236x/52/09/e5/5209e5221862e0d1369402b52a5e63a1--scenery-photography-winter-photography.jpg",
      "https://i.pinimg.com/originals/fc/2b/01/fc2b0102571e03eaf6f160b9ce16034a.jpg",
      "https://i.pinimg.com/originals/5d/b1/9e/5db19ed4d165f8f00884f0a2c6b5bdfb.jpg",
      "https://i.pinimg.com/originals/88/60/31/886031fffff6078d3cfa4879666405ca.jpg",
      "https://i.pinimg.com/736x/c2/5f/37/c25f37f4cc871171c09555a58013e7d9.jpg"
    ];
    var rndmPick = new Random();
    int index = rndmPick.nextInt(5);
    return images[index];
  }

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
