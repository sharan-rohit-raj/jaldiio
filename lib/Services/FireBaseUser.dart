
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaldiio/Models/user.dart';
import 'package:jaldiio/Services/DataBaseService.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid, email: user.email, imgURL: user.photoUrl) : null;
  }

  //auth change user stream
  Stream<User> get user_stream {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
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
        return _userFromFirebaseUser(fireuser);
    }catch(e){
       print(e.toString());
       return null;
    }
  }

  //ReAuthenticate User
  Future reAuth(String email, String password) async{
    try{
      FirebaseUser user = await _auth.currentUser();
      AuthCredential credential = EmailAuthProvider.getCredential(
        email: email,
        password: password,
      );
      AuthResult result = await user.reauthenticateWithCredential(credential);
      return result;
    }catch(e){
      print("Error in login.");
      return null;
    }
  }


  //Delete Account
  Future deleteAccount() async{
    try{
      FirebaseUser user = await _auth.currentUser();
      return await user.delete();
    }catch(e){
      print(e.toString());
      print("Cannot perform delete account action.");
      return null;
    }
  }

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
        print("Unable to Sign Out.");
       print(e.toString());
       return null;
    }
  }

  //User Image upload
  Future uploadProfileImage(String photoURL) async{
    try{
      FirebaseUser user = await _auth.currentUser();
      UserUpdateInfo updateInfo = new UserUpdateInfo();
      updateInfo.photoUrl = photoURL;
      return await user.updateProfile(updateInfo);
    }catch(e){
      print("Unable to upload.\n Reason: " + e.toString());
      return null;
    }
  }

}