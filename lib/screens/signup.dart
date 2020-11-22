import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plushvie_demo/helper/helper_methods.dart';
import 'package:plushvie_demo/screens/home_screen.dart';
import 'package:plushvie_demo/screens/login.dart';
import 'package:plushvie_demo/services/auth.dart';
import 'package:plushvie_demo/services/database.dart';
import 'package:plushvie_demo/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullNameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  AuthMethods _authMethods = AuthMethods();
  HelperMethods _helperMethods = HelperMethods();
  DatabaseMethods _databaseMethods = DatabaseMethods();

  void signUp(){
    if (_formKey.currentState.validate()){

      Map<String,String> userInfoMap = {
        "fullName" : fullNameTEC.text,
        "email" : emailTEC.text
      };
      _helperMethods.setEmailSP(emailTEC.text);
      _helperMethods.setFullNameSP(fullNameTEC.text);
      _helperMethods.setUserLoggedInStatusSP(true);
      setState(() {
        isLoading = true;
      });

      DatabaseMethods databaseMethods = DatabaseMethods();

      _authMethods.signUpWithEmailAndPassword(emailTEC.text,passwordTEC.text).then((val){
        databaseMethods.uploadData(userInfoMap);
        isLoading = false;
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeScreen()
        ));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : Builder(
        builder: (context) {
          return Container(
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
                            validator: (value){
                              if (value.isEmpty || value.length<6){
                                return "Enter a valid Username";
                              }
                              else
                                return null;
                            },
                            controller: fullNameTEC,
                            style: TextStyle(color: Colors.white),
                            decoration: textFieldInputDecoration("Full name (People will search you by this)"),
                          ),
                          SizedBox(height: 16.0,),
                          TextFormField(
                            validator: (value){
                              return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                                  ? null
                                  : "Please enter valid Email ID";
                            },
                            controller: emailTEC,
                            style: TextStyle(color: Colors.white),
                            decoration: textFieldInputDecoration("Email ID"),
                          ),
                          SizedBox(height: 16.0,),
                          TextFormField(
                            obscureText: true,
                            validator: (value){
                              if (value.isEmpty || value.length<4){
                                return "Password too weak";
                              }
                              else
                                return null;
                            },
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
                        if(passwordTEC.text.length<6){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Password too weak"),
                            action: SnackBarAction(
                              label: "OK",
                              onPressed: (){},
                            ),
                          ));
                        }
                        else signUp();
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
                        child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 17.0),textAlign: TextAlign.center,),
                      ),
                    ),
                    SizedBox (height: 30.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",style: TextStyle(color: Colors.white,fontSize: 16.0),),
                        GestureDetector(
                          child: Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 16.0,decoration: TextDecoration.underline),),
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LoginScreen()
                            ));
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 110.0,)
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
