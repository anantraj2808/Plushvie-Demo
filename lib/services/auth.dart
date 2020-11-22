import 'package:firebase_auth/firebase_auth.dart';
import 'package:plushvie_demo/helper/helper_methods.dart';
import 'package:plushvie_demo/models/users.dart';

class AuthMethods{

  FirebaseAuth _auth = FirebaseAuth.instance;
  HelperMethods _helperMethods = HelperMethods();
  //User _currentUser;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //if (result.user != null) _currentUser = result.user;
      return result.user != null ? Users(userId: result.user.uid) : null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user != null ?Users(userId: result.user.uid) : null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      _helperMethods.setUserLoggedInStatusSP(false);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //User get currentUser => _currentUser;

}