import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jaldiio/Models/UserInformation.dart';
import 'package:jaldiio/Models/UserValue.dart';

class DataBaseService{

    final String uid;
    DataBaseService({this.uid});

  //Collection reference
  final CollectionReference userCollection = Firestore.instance.collection(
    'user_info'
  );

  Future updateUserInfo(String name, String status, String date, int phone_num) async{
    return await userCollection.document(uid).setData({
      'name': name,
      'status': status,
      'DOB': date,
      'phone_num': phone_num,
    });
  }

  //User data from snapshot
    UserValue _userValue(DocumentSnapshot snapshot){
    return UserValue(
      uid: uid,
      name: snapshot.data['name'] ?? '',
      status: snapshot.data['status'] ?? '',
      phoneNum: snapshot.data['phone_num'] ?? 0,
      date: snapshot.data['DOB'] ?? '0',
    );
    }

  //User values from snapshot
    List<UserInformation> _userLisFromSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
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

  Stream<UserValue> get userData{
    return userCollection.document(uid).snapshots().map(_userValue);
  }
}