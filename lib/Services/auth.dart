import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user_stream {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }
  //Sign in anon
  Future signInAnonymous() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signinWithEmailAndPassword(String email, String password) async{
    try{
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser  fireuser = result.user;   
        return _userFromFirebaseUser(fireuser);
    }catch(e){
       print(e.toString());
       return null;
    }
  }

 //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser  fireuser = result.user;

        //create new doc for user
//        await DataBaseService(uid: fireuser.uid).updateUserInfo("Sharan", "Hey yo", 22, 3657774973);
        return _userFromFirebaseUser(fireuser);
    }catch(e){
       print(e.toString());
       return null;
    }
  }

  //register

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
       print(e.toString());
       return null;
    }
  }

}