import 'package:firebase_app/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  Users _userFromFirebaseUser (User user) {
    return user != null ? Users(uid: user.uid) : null;
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

  //register with email and password

  //sign-out

}
