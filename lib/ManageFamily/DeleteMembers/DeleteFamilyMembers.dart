import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';


class DeleteFamilMembers extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  String codeController;
  String familyCode;
  String value = "";
  GlobalKey<FormState> formKey;
  DeleteFamilMembers({Key key, @required this.scaffoldKey, this.codeController, this.familyCode, this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contacts = Provider.of<List<Contact>>(context);
    return FlatButton(
      padding: EdgeInsets.only(left: 100, right: 100),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              color: Colors.deepPurpleAccent)),
      child: Text(
        "Delete",
        style: GoogleFonts.openSans(
            fontSize: 18,
            color: Colors.deepPurpleAccent),
      ),
      onPressed: () async{


        if(formKey.currentState.validate()) {
//                                  send();.
//        print(codeController);
          if(familyCode.compareTo(codeController) == 0 ){
                final FirebaseUser fireuser =
                await FirebaseAuth.instance.currentUser();

                await DataBaseService(uid: fireuser.uid).leaveFamily();
                await DataBaseService(uid: fireuser.uid).updateAdmin(false);
                await DataBaseService(uid: fireuser.uid).updateJoined(false);


                int i =0;
                while(i < contacts.length){
                  String uid = contacts[i].uid;
                  String name_id = contacts[i].name+"_"+contacts[i].phNo.toString();
                  await DataBaseService(uid: uid).leaveFamily();
                  await DataBaseService(uid: uid).updateJoined(false);

                  //Delete Contact Doc
                  await DataBaseService(famCode: familyCode).deleteContactDoc(name_id);
                  i++;
                }

                await DataBaseService(famCode: familyCode).deleteContactsList();
                await DataBaseService(famCode: familyCode).deleteMembersList();
                await DataBaseService(famCode: familyCode).deleteTodoList();
                await DataBaseService(famCode: familyCode).deleteRecipesList();
                await DataBaseService(famCode: familyCode).deleteFamilyEventsList();

                await DataBaseService(famCode: familyCode)
                    .deleteFamily();

                value ="Family deleted successfully.";
              scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));

          }
          else{
            value ="Oh..Oh tha's not what we are looking for. Please try again.";
            scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
          }
        }
      },
    );
  }
}
