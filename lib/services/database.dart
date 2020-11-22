import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods{

  uploadData(userInfoMap){
    var docId = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection("Users").doc(docId).set(userInfoMap);
  }

  getUserByEmail(String email) async {
    return await FirebaseFirestore.instance.collection("Users").where(
      "email" , isEqualTo: email
    ).get();
  }

  addToRecords(email,tempMap) async {
    var user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("Records").add(tempMap);
  }
}