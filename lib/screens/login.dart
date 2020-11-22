import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plushvie_demo/helper/helper_methods.dart';
import 'package:plushvie_demo/screens/home_screen.dart';
import 'package:plushvie_demo/screens/signup.dart';
import 'package:plushvie_demo/services/auth.dart';
import 'package:plushvie_demo/services/database.dart';
import 'package:plushvie_demo/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  DatabaseMethods _databaseMethods = DatabaseMethods();
  HelperMethods _helperMethods = HelperMethods();
  AuthMethods _authMethods = AuthMethods();

  AuthMethods authMethods = AuthMethods();
  signIn(){
    if (_formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });

      _helperMethods.setEmailSP(emailTEC.text);
      _databaseMethods.getUserByEmail(emailTEC.text).then((val){
        if (val != null){
          snapshotUserInfo = val;
          _helperMethods.setFullNameSP(snapshotUserInfo.docs[0].data()['fullName']);
        }
      });

      _authMethods.signInWithEmailAndPassword(emailTEC.text, passwordTEC.text).then((val){
        if (val != null){
          _helperMethods.setUserLoggedInStatusSP(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => HomeScreen()
          ));
        }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailTEC,
                        validator: (value){
                          return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
                              ? null
                              : "Please enter valid Email ID";
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: textFieldInputDecoration("Email ID"),
                      ),
                      SizedBox(height: 16.0,),
                      TextFormField(
                        validator: (value){
                          if (value.isEmpty || value.length<4){
                            return "Password too weak";
                          }
                          else
                            return null;
                        },
                        obscureText: true,
                        controller: passwordTEC,
                        style: TextStyle(color: Colors.white),
                        decoration: textFieldInputDecoration("Password"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0,),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff007EF4),
                            const Color(0xff2A75BC)
                          ],
                        )
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 17.0),textAlign: TextAlign.center,),
                  ),
                ),
                SizedBox (height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                    GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => SignUpScreen()
                          ));
                        },
                        child: Text("Create One",style: TextStyle(color: Colors.white,fontSize: 16.0,decoration: TextDecoration.underline),)
                    ),
                  ],
                ),
                SizedBox(height: 50.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
