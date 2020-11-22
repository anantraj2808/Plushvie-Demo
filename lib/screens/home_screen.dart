import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plushvie_demo/helper/helper_methods.dart';
import 'package:plushvie_demo/screens/login.dart';
import 'package:plushvie_demo/services/auth.dart';
import 'package:plushvie_demo/services/database.dart';
import 'package:plushvie_demo/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  AuthMethods _authMethods = AuthMethods();
  HelperMethods _helperMethods = HelperMethods();
  DatabaseMethods _databaseMethods = DatabaseMethods();
  TextEditingController _textEditingController = TextEditingController();


  @override
  void initState() {
    //getEmail();
    super.initState();
  }

//  getEmail() async {
//    await _helperMethods.getFullNameSP().then((value){
//      email = value;
//    });
//    setState(() {
//    });
//  }

  setTemp(temp) async {
    Map<String,dynamic> tempMap = {
      "temp" : temp,
      "time" : DateTime.now().millisecondsSinceEpoch
    };
    String email = "";
    await _helperMethods.getEmailSP().then((value){
      email = value;
    });
    _databaseMethods.addToRecords(email, tempMap);
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("What's your body Temperature? (in °C)"),
            content: TextField(
              controller: _textEditingController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Eg. Enter 45.5 for 45.5°C"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  setTemp(_textEditingController.text.toString());
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          GestureDetector(
            onTap: (){
              _authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => LoginScreen()
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.exit_to_app,color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          //child: Text(email,style: TextStyle(color: Colors.white),),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _displayDialog(context);
        },
      ),
    );
  }
}
