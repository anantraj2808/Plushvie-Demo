import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plushvie_demo/helper/helper_methods.dart';
import 'package:plushvie_demo/screens/home_screen.dart';
import 'package:plushvie_demo/screens/login.dart';
import 'package:plushvie_demo/widgets/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isUserLoggedIn;
  HelperMethods _helperMethods = HelperMethods();

  @override
  void initState() {
    getLoggedInStatus();
    super.initState();
  }

  getLoggedInStatus() {
    _helperMethods.getUserLoggedInStatusSP().then((value){
      isUserLoggedIn = value;
    });
    setState(() {
    });
  }

  Widget initScreen(){
    if ( isUserLoggedIn == null || isUserLoggedIn == false) return LoginScreen();
    else return HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plushvie Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1f1f1f),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: initScreen(),
    );
  }
}

