import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaldiio/Models/Contact.dart';
import 'package:jaldiio/Models/FamilyCodeValue.dart';
import 'package:jaldiio/Models/ImageTags.dart';
import 'package:jaldiio/Models/ImageUrls.dart';
import 'package:jaldiio/Models/Task.dart';
import 'package:jaldiio/Models/UserInformation.dart';
import 'package:jaldiio/Models/UserValue.dart';
import 'package:jaldiio/Models/FamEvent.dart';
import 'dart:math';

import 'package:jaldiio/Services/CloudStorageService.dart';

class DataBaseService {
  final String uid;
  final String famCode;
  DataBaseService({this.uid, this.famCode});

  //Collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('user_info');
  final CollectionReference familyCollection =
      Firestore.instance.collection('family_info');

  String capitalize(String string) {
    if (string == null) {
      throw ArgumentError("string: $string");
    }

    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1).toLowerCase();
  }

  Future updateUserInfo(String name, String status, String date, int phone_num) async {
    return await userCollection.document(uid).setData({
      'name': capitalize(name),
      'status': capitalize(status),
      'DOB': date,
      'phone_num': phone_num,
      'admin': false,
      'joined': false,
    });
  }

  Future updateTags(List<String> tags) async{
    return await familyCollection.document(famCode).collection("images")
        .document("tagList").updateData({
      'tagValues': FieldValue.arrayUnion(tags)
    });
  }

  Future updateMembers(String name, int phNo) async{
    String nameid = name.toLowerCase()+"_"+phNo.toString();
    familyCollection
        .document(famCode)
        .collection("members")
        .document(nameid)
        .setData({
      'uid': uid,
      'nameID': nameid,
    });
  }

  Future updateFamilyCode(String familyID) async {
    return await userCollection.document(uid).updateData({
      'familyID': familyID,
    });
  }

  Future updateAdmin(bool admin) async{
    return await userCollection.document(uid).updateData({
      'admin': admin,
    });
  }

  Future updateJoined(bool joined) async{
    return await userCollection.document(uid).updateData({
      'joined': joined,
    });
  }


  Future updateTaskCheck(bool checked, String id) async {
    return await familyCollection
        .document(famCode)
        .collection("todos")
        .document(id)
        .updateData({
      'check': checked,
    });
  }

  Future deleteUserProfile() async{
    return await userCollection.document(uid).delete();
  }

  Future deleteTask(String id) async {
    return await familyCollection
        .document(famCode)
        .collection("todos")
        .document(id).delete();
  }

  Future deleteEvent(String id) async {
    return await familyCollection
        .document(famCode)
        .collection("familyEvent")
        .document(id).delete();
  }

  Future deleteFamily() async{
    return await familyCollection.document(famCode).delete();
  }
  Future leaveFamily() async{
    return await userCollection.document(uid).updateData({
      'familyID' :FieldValue.delete(),
    });
  }
  Future removeMember(String name_id) async{
    return await familyCollection.document(famCode).collection("members").document(name_id).delete();
  }

  Future deleteImgTag(String tag) async{
    List<String> tags = new List<String>();
    tags.add(tag);
    return await familyCollection.document(famCode).collection("images")
        .document("tagList").updateData({
      'tagValues': FieldValue.arrayRemove(tags)
    });
  }

  Future deleteImg(String id) async{
    return await familyCollection.document(famCode).collection("images").document(id).delete();
  }

  Future deleteContactDoc(String name_id) async{
    try{
      return await familyCollection
          .document(famCode)
          .collection("contacts")
          .document(name_id).delete();
    }
    catch(e){
      print("Unable to delete contact.");
      return null;
    }

  }

  Future deleteTodoList() async{
    return await familyCollection
        .document(famCode)
        .collection("todos").getDocuments().then((snapshot) {
          for(DocumentSnapshot ds in snapshot.documents){
            ds.reference.delete();
          }
    });
  }
  Future deleteMembersList() async{
    return await familyCollection
        .document(famCode)
        .collection("members").getDocuments().then((snapshot) {
      for(DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
  }

  Future deleteContactsList() async{
    return await familyCollection
        .document(famCode)
        .collection("contacts").getDocuments().then((snapshot) {
      for(DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
  }


  Future deleteFamilyEventsList() async{
    return await familyCollection
        .document(famCode)
        .collection("familyEvents").getDocuments().then((snapshot) {
      for(DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
  }

  Future deleteImagesList() async{
    return await familyCollection
        .document(famCode)
        .collection("images").getDocuments().then((snapshot) {
      for(DocumentSnapshot ds in snapshot.documents){
        
        if(ds.reference.documentID.compareTo("tagList") != 0){
          try{
            CloudStorageService(famCode: famCode).deleteImage(ds.reference.documentID).then((value) {
              ds.reference.delete();
            });
          }catch(e){
            print(e.toString());
          }
        }else{
          ds.reference.delete();
        }


      }
    });
  }

  Future deleteRecipesList() async{
    return await familyCollection
        .document(famCode)
        .collection("recipes").getDocuments().then((snapshot) {
      for(DocumentSnapshot ds in snapshot.documents){

        if(ds.reference.documentID.compareTo("tagList") != 0){
          try{
            CloudStorageService(famCode: famCode).deleteImage(ds.reference.documentID).then((value) {
              ds.reference.delete();
            });
          }catch(e){
            print(e.toString());
          }
        }else{
          ds.reference.delete();
        }


      }
    });
  }
  Future initializeDocField() async{
    return await familyCollection.document(famCode).setData({
      'code': famCode,
    });
  }
  Future initializeImageTagField() async{
    List<String> initialList = new List<String>();
    initialList.add("#Happy");
    return await familyCollection.document(famCode).collection("images").
    document("tagList").setData({
      'tagValues': FieldValue.arrayUnion(initialList),
    });
  }

  // Might need if recipe has tags
//  Future initializeRecipeTagField() async{
//    List<String> initialList = new List<String>();
//    initialList.add("");
//    return await familyCollection.document(famCode).collection("recipes").
//    document("tagList").setData({
//      'tagValues': FieldValue.arrayUnion(initialList),
//    });
//  }

  Future updateContactsInfo(String emailId, String name, int phNo) async {
    String name_id = emailId;

    return await familyCollection
        .document(famCode)
        .collection("contacts")
        .document(name_id)
        .setData({
      'emailID': emailId,
      'name': capitalize(name),
      'phNo': phNo,
      'joined': false,
      'uid': null,
	  'photoURL': null,
    });
  }

  Future updateEvents(String title, String description, String date) async{
    var random = Random.secure();

    var value = random.nextInt(1000000000);
    String event_id = value.toString();
    return await familyCollection
        .document(famCode)
        .collection("familyEvent")
        .document(event_id)
        .setData({
      'title': capitalize(title),
      'description': description,
      'id': event_id,
      'eventDate' : date,

    });
  }

  Future updateContactjoined(String id, bool joined, String photoURL) async{
    String name_id = id;
    return await familyCollection
        .document(famCode)
        .collection("contacts")
        .document(name_id).updateData({
      'joined': joined,
	  'photoURL': photoURL,
    });
  }

  Future updateContactUID(String id, String uid) async{
    String name_id = id;
    return await familyCollection
        .document(famCode)
        .collection("contacts")
        .document(name_id).updateData({
      'uid': uid,

    });
  }

  Future addImageURL(String name, String id, String url, List<String> tags) async{
    return await familyCollection
        .document(famCode)
        .collection("images")
        .document(id).setData({
      'url' : url,
      'name': capitalize(name),
      'id': id,
      'tag': tags,

    });
  }

  Future addImageTag(String id, List tags) async{

    return await familyCollection
        .document(famCode)
        .collection("images")
        .document(id).updateData({
      'tags': tags,
    });
  }

  Future updateTasks(String task, bool check) async{
    var random = Random.secure();

    var value = random.nextInt(1000000000);
    String task_id = value.toString();
    return await familyCollection
        .document(famCode)
        .collection("todos")
        .document(task_id)
        .setData({
        'task': capitalize(task),
        'check': check,
        'id': task_id,

    });
  }


  List<Contact> _contactListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Contact(
        name: doc.data['name'] ?? '',
        phNo: doc.data['phNo'] ?? 0,
        emaild: doc.data['emailID'] ?? '',
        joined: doc.data['joined'] ?? false,
        uid: doc.data['uid'] ?? '',
		photoURL: doc.data['photoURL'] ?? '',
      );
    }).toList();
  }

  List<ImageUrls> _urlListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ImageUrls(
        url: doc.data['url'] ?? '',
        name: doc.data['name'] ?? '',
        id: doc.data['id'] ?? '',
      );
    }).toList();
  }


  List<Task> _taskListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Task(
        task: doc.data['task'] ?? '',
        check: doc.data['check'] ?? false,
        id: doc.data['id'] ?? '',
      );
    }).toList();
  }

  List<EventModel> _eventListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return EventModel(
        description: doc.data['description'] ?? '',
        eventDate: doc.data['eventDate'] ?? '',
        id: doc.data['id'] ?? '',
        title: doc.data['title'] ?? '',
      );
    }).toList();
  }

  //User data from snapshot
  UserValue _userValue(DocumentSnapshot snapshot) {
    return UserValue(
      uid: uid,
      name: snapshot.data['name'] ?? '',
      status: snapshot.data['status'] ?? '',
      phoneNum: snapshot.data['phone_num'] ?? 0,
      date: snapshot.data['DOB'] ?? '0',
      familyID: snapshot.data['familyId'] ?? '',
      admin: snapshot.data['admin'] ?? false,
      joined: snapshot.data['joined'] ?? false,
    );
  }

  ImageTags _imageTags(DocumentSnapshot snapshot){
    List<String> emptyList = new List<String>();
    emptyList.add("");
    return ImageTags(
      tags: List.from(snapshot.data['tagValues']) ?? emptyList,
    );
  }

  FamilyCodeValue _familyCodeValue(DocumentSnapshot snapshot) {
    return FamilyCodeValue(
      familyID: snapshot.data['familyID'] ?? '',
      uid: uid,
      admin: snapshot.data['admin'] ?? false,
    );
  }

  //User values from snapshot
  List<UserInformation> _userLisFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserInformation(
        name: doc.data['name'] ?? '', //Return name or else null string
        phoneNum: doc.data['phone_num'] ?? 0, //Return phone_num or else 0
        age: doc.data['date'] ?? 0, //Return age or else 0
        status: doc.data['status'] ?? '', //Return status or else null
      );
    }).toList();
  }

  Stream<List<UserInformation>> get infos {
    return userCollection.snapshots().map(_userLisFromSnapShot);
  }

  Stream<ImageTags> get imgTagData{
    return familyCollection.document(famCode).collection("images")
        .document("tagList").snapshots()
        .map(_imageTags);
  }

  Stream<UserValue> get userData {
    return userCollection.document(uid).snapshots().map(_userValue);
  }

  //get contacts stream
  Stream<List<Contact>> get contacts {
    return familyCollection
        .document(famCode)
        .collection("contacts")
        .snapshots()
        .map(_contactListFromSnapShot);
  }

  //get tasks stream
  Stream<List<Task>> get tasks{
    return familyCollection
        .document(famCode)
        .collection("todos")
        .snapshots()
        .map(_taskListFromSnapShot);
  }

  //get events stream
  Stream<List<EventModel>> get events{
    return familyCollection
        .document(famCode)
        .collection("familyEvent")
        .snapshots()
        .map(_eventListFromSnapShot);
  }

  //get urls stream
  Stream<List<ImageUrls>> get urls{
    return familyCollection
        .document(famCode)
        .collection("images")
        .snapshots()
        .map(_urlListFromSnapShot);
  }

  Stream<FamilyCodeValue> get codeData{
    return userCollection.document(uid).snapshots().map(_familyCodeValue);
  }

//  Stream queryDb({String tag = 'favorites'}){
//    Query query = familyCollection
//        .document(famCode)
//        .collection("images").where("tags", arrayContains: tag);
//    Stream slides = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
//
//  }
}
