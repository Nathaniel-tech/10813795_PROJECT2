import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  //Sign up with email and password
  Future register(String email, String password) async {
    try {
      AuthResult register = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = register.user;
      print(_user.uid);
      return _user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email and password
  Future signIn(String email, String password) async {
    try {
      AuthResult login = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = login.user;
      print(_user.uid);
      return _user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // log out
  Future signOut() async {
    await _auth.signOut();
    return null;
  }

  //Store user info on firebase
  Future userInfo(String name) async {
    if (_user != null) {
      await Firestore.instance.collection("Users").document(_user.uid).setData({
        "Username": name,
        "email": _user.email,
        "uid": _user.uid
      });
    }
  }

  //Auth Stream
  Stream<FirebaseUser> get status {
    return _auth.onAuthStateChanged;
  }
}
