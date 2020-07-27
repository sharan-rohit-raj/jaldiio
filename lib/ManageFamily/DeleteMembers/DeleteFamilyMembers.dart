import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jaldiio/Animation/FadeAnimation.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:jaldiio/Services/CloudStorageService.dart';
import 'package:jaldiio/Services/DataBaseService.dart';
import 'package:provider/provider.dart';


class DeleteFamilMembers extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  String codeController;
  String familyCode;
  String value = "";
  GlobalKey<FormState> formKey;
  DeleteFamilMembers({Key key, @required this.scaffoldKey, this.codeController, this.familyCode, this.formKey}) : super(key: key);

  void showSnackBar(String value, GlobalKey<ScaffoldState> key) {
    key.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  }

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
                value ="Delete in progress...";
                scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));

                try{
                  await DataBaseService(famCode: familyCode).deleteImagesList();
                }catch(e){
                  print(e.toString());
                  print("Unable to delete Images List.");
                }

                try{
                  await DataBaseService(uid: fireuser.uid).leaveFamily();
                  await DataBaseService(uid: fireuser.uid).updateAdmin(false);
                  await DataBaseService(uid: fireuser.uid).updateJoined(false);
                }
                catch(e){
                  print(e.toString());
                }



                int i =0;
                bool stopLoop = false;
                while(i < contacts.length && !stopLoop){
                  String uid = contacts[i].uid;
                  String name_id = contacts[i].emaild;

                  try{
                    await DataBaseService(uid: uid).leaveFamily();
                    await DataBaseService(uid: uid).updateJoined(false);

                    //Delete Contact Doc
                    await DataBaseService(famCode: familyCode).deleteContactDoc(name_id);
                  }
                  catch(e){
                    stopLoop = true;
                    print(e.toString());
                  }

                  i++;
                }
                try{
                  await DataBaseService(famCode: familyCode).deleteContactsList();
                }catch(e){
                  print(e.toString());
                  print("Unable to delete Contact List");
                }
                try{
                  await DataBaseService(famCode: familyCode).deleteTodoList();
                }catch(e){
                  print(e.toString());
                  print("Unable to delete Todo List");
                }
                try{
                  await DataBaseService(famCode: familyCode).deleteRecipesList();
                }catch(e){
                  print(e.toString());
                  print("Unable to delete Recipes List");
                }
                try{
                  await DataBaseService(famCode: familyCode).deleteFamilyEventsList();
                }catch(e){
                  print(e.toString());
                  print("Unable to delete Events List");
                }
                try{
                  await DataBaseService(famCode: familyCode)
                      .deleteFamily();
                }catch(e){
                  print(e.toString());
                  print("Unable to delete Family Collection");
                }

                value ="Family deleted successfully.";
              scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));

          }
          else{
            value ="Oh..Oh that's not what we are looking for. Please try again.";
            scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
          }
        }
      },
    );
  }
}
