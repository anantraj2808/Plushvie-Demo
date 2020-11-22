import 'package:shared_preferences/shared_preferences.dart';

class HelperMethods{

  static String sharedPreferenceLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceFullNameKey = "FULLNAMEKEY";
  static String sharedPreferenceEmailKey = "EMAILKEY";

  //Setting Data into Shared Preferences
  Future<void> setUserLoggedInStatusSP(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceLoggedInKey, isLoggedIn);
  }

  Future<void> setFullNameSP(String fullName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceFullNameKey, fullName);
  }

  Future<void> setEmailSP(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceEmailKey, email);
  }


  //Getting Data from Shared Preferences
  Future<bool> getUserLoggedInStatusSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceLoggedInKey);
  }

  Future<String> getFullNameSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceFullNameKey);
  }

  Future<String> getEmailSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceEmailKey);
  }
}