import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService{
  final String famCode;

  CloudStorageService({this.famCode});

  StorageReference imageRef = FirebaseStorage.instance.ref().child("Families");

  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1).toLowerCase();
  }
  StorageReference Imagesref(String name){
    print(famCode);
    return imageRef.child(famCode).child("Images").child(capitalize(name));

  }
  StorageReference Recipesref(String recipeCode, File file) {
    return imageRef.child(famCode).child("Recipes").child(capitalize(recipeCode));
  }

  Future deleteImage(String id) async{
    return await imageRef.child(famCode).child("Images").child(id).delete();
  }

  Future deleteAllFamilyImages() async{

    if(await imageRef.child(famCode).child("Images").getName() != null){
      print(await imageRef.child(famCode).child("Images").getPath());
      await imageRef.child(famCode).child("Images").delete();
    }

    if (await imageRef.child(famCode).child("Recipes").getName() != null) {
      print(await imageRef.child(famCode).child("Recipes").getName());
      await imageRef.child(famCode).child("Recipes").delete();
    }


  }

}