import 'package:firebase_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  Users _userFromFirebaseUser (User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }
  
  //sign-in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign-in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
    }
  }

  //sign-out
  Future signOut() async {
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
